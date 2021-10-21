import os
import mysql.connector
import MySQLdb.cursors
import pandas as pd
import numpy as np
from copy import deepcopy
import random
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, Dataset


def cdb():
  db = mysql.connector.connect(
      user='root',
      password='password',
      host='db',
      database='app'
  )
  return db

config = {'alias': 'gmf_factor8neg4-implict',
              'num_epoch': 100, # 200
              'batch_size': 1024,
              'optimizer': 'adam',
              'adam_lr': 1e-3,
              'num_users': 6040,
              'num_items': 3706,
              'latent_dim': 8,
              'num_negative': 4,
              'l2_regularization': 0, # 0.01
              'use_cuda': True,
              'device_id': 0,
              'model_dir':'checkpoints/{}_Epoch{}_HR{:.4f}_NDCG{:.4f}.model'}


def get_data():
  db = cdb()
  df = pd.read_sql('SELECT click_id, clicked_id, flag, time FROM Clicks', db)

  return df


def preprocess_dataset(df):
  user_id = df[['click_id']].drop_duplicates().reindex()  # ['uid']で取るとSeries型になるので[['uid']]で取得
  user_id['click_id'] = np.arange(len(user_id))
  df = pd.merge(df, user_id, on=['click_id'], how='left')
  clicked_id = df[['clicked_id']].drop_duplicates()
  clicked_id['clicked_id'] = np.arange(len(clicked_id))
  df = pd.merge(df, clicked_id, on='clicked_id', how='left')
  df = df[['click_id', 'clicked_id', 'flag', 'time']]

  return df


class SampleGenerator(object):
  def __init__(self, ratings):
    self.ratings = ratings
    self.preprocess_ratings = self._binarize(ratings)  # ratingを全て1に変換
    self.user_pool = set(self.ratings['click_id'].unique())  # ユーザーの集合体の作成
    self.item_pool = set(self.ratings['clicked_id'].unique())  # アイテムの集合体の作成
    self.negatives = self._sample_negative(
      ratings)  # 反応していないitemIdと99個のランダムに抽出されたitemIdをくっつける
    self.train_ratings, self.test_ratings = self._split_train_test(
      self.preprocess_ratings)  # 最新のレビューがテスト/それ以外がtrain

  def _binarize(self, ratings):
    ratings = deepcopy(ratings)
    ratings['flag'][ratings['flag'] > 0] = 1.0

    return ratings

  def _sample_negative(self, ratings):
    interact_status = ratings.groupby('click_id')['time'].apply(
      set).reset_index().rename(
      columns={
        'time': 'interacted_items'})  # interacted_itemsにレビューしたitemIdの集合体が入る
    interact_status['negative_items'] = interact_status[
      'interacted_items'].apply(lambda x: self.item_pool - x)
    interact_status['negative_samples'] = interact_status[
      'negative_items'].apply(lambda x: random.sample(x, 10)) # 99だった

    return interact_status[['click_id', 'negative_items', 'negative_samples']]

  def _split_train_test(self, ratings):
    ratings['rank_latest'] = ratings.groupby(['click_id'])['time'].rank(
      method='first', ascending=False)
    test = ratings[ratings['rank_latest'] == 1]
    train = ratings[ratings['rank_latest'] > 1]

    return train[['click_id', 'clicked_id', 'flag']], test[
      ['click_id', 'clicked_id', 'flag']]

  def instance_a_train_loader(self, num_negatives, batch_size):
    click_users, clicked_users, ratings = [], [], []
    train_ratings = pd.merge(self.train_ratings,
                             self.negatives[['click_id', 'negative_items']],
                             on='click_id')
    train_ratings['negatives'] = train_ratings['negative_items'].apply(
      lambda x: random.sample(x, num_negatives))
    for row in train_ratings.itertuples():
      click_users.append(int(row.click_id))
      clicked_users.append(int(row.clicked_id))
      ratings.append(float(row.flag))
      for i in range(num_negatives):
        click_users.append(int(row.click_id))
        clicked_users.append(int(row.negatives[i]))
        ratings.append(float(0))  # negative samples get 0 rating
    dataset = UserItemRatingDataset(user_tensor=torch.LongTensor(click_users),
                                    item_tensor=torch.LongTensor(clicked_users),
                                    target_tensor=torch.FloatTensor(ratings))
    return DataLoader(dataset, batch_size=batch_size, shuffle=True)

  @property
  def evaluate_data(self):
    test_ratings = pd.merge(self.test_ratings,
                            self.negatives[['click_id', 'negative_samples']],
                            on='click_id')
    test_users, test_items, negative_users, negative_items = [], [], [], []
    for row in test_ratings.itertuples():
      test_users.append(int(row.click_id))
      test_items.append(int(row.clicked_id))
      for i in range(len(row.negative_samples)):
        negative_users.append(int(row.click_id))
        negative_items.append(int(row.negative_samples[i]))

    return [torch.LongTensor(test_users), torch.LongTensor(test_items),
            torch.LongTensor(negative_users),
            torch.LongTensor(negative_items)]


class UserItemRatingDataset(Dataset):
  """Wrapper, convert <user, item, rating> Tensor into Pytorch Dataset"""

  def __init__(self, user_tensor, item_tensor, target_tensor):
    """
    args:

        target_tensor: torch.Tensor, the corresponding rating for <user, item> pair
    """
    self.user_tensor = user_tensor
    self.item_tensor = item_tensor
    self.target_tensor = target_tensor

  def __getitem__(self, index):
    return self.user_tensor[index], self.item_tensor[index], self.target_tensor[
      index]

  def __len__(self):
    return self.user_tensor.size(0)


class GMF(torch.nn.Module):
  def __init__(self, config):
    super(GMF, self).__init__()
    self.num_users = config['num_users']
    self.num_items = config['num_items']
    self.latent_dim = config['latent_dim']
    self.embedding_user = torch.nn.Embedding(num_embeddings=self.num_users,
                                             embedding_dim=self.latent_dim)
    self.embedding_item = torch.nn.Embedding(num_embeddings=self.num_items,
                                             embedding_dim=self.latent_dim)
    self.affine_output = torch.nn.Linear(in_features=self.latent_dim,
                                         out_features=1)
    self.logistic = torch.nn.Sigmoid()

  def forward(self, user_indices, item_indices):
    user_embedding = self.embedding_user(user_indices)
    item_embedding = self.embedding_item(item_indices)
    element_product = torch.mul(user_embedding, item_embedding)
    logits = self.affine_output(element_product)
    rating = self.logistic(logits)
    return rating


def model():
  device = 'cuda' if torch.cuda.is_available() else 'cpu'
  model = GMF(config).to(device)
  return model


def train(train_loader):
  model.train()
  total_loss = 0
  # 誤差関数の設定
  criterion = nn.BCELoss()
  # 重みを学習する際の最適化手法の選択
  optimizer = optim.Adam(model.parameters(), lr=0.01)

  for batch_id, batch in enumerate(train_loader):
    assert isinstance(batch[0], torch.LongTensor)
    user, item, rating = batch[0], batch[1], batch[2]
    ratings = rating.float()
    optimizer.zero_grad()
    output = model(user, item)
    loss = criterion(output.view(-1), ratings)
    loss.backward()
    optimizer.step()
    loss = loss.item()
    total_loss += loss


def test(eval_data):
  model.eval()
  test_users, test_items = eval_data[0], eval_data[1]
  negative_users, negative_items = eval_data[2], eval_data[3]
  test_scores = model(test_users, test_items)
  negative_scores = model(negative_users, negative_items)

  return test_scores, negative_scores

