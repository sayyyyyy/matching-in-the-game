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
