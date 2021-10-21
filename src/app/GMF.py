import os
import pandas as pd
import numpy as np
from copy import deepcopy
import random
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, Dataset

import mysql.connector
import MySQLdb.cursors

def aaa(a, b):
    return a+b

def cdb():
  db = mysql.connector.connect(
      user='root',
      password='password',
      host='db',
      database='app'
  )
  return db

def data_1(b):
    b = 5
    db = cdb()
    a = db.cursor()
    a.execute('SELECT * FROM Profiles')
    a = a.fetchall()
    return a


config = {'alias': 'gmf_factor8neg4-implict',
              'num_epoch': 100, # 200
              'batch_size': 1024,
              # 'optimizer': 'sgd',
              # 'sgd_lr': 1e-3,
              # 'sgd_momentum': 0.9,
              # 'optimizer': 'rmsprop',
              # 'rmsprop_lr': 1e-3,
              # 'rmsprop_alpha': 0.99,
              # 'rmsprop_momentum': 0,
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

