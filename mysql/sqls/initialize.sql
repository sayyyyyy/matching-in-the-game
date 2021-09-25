CREATE DATABASE IF NOT EXISTS app;
use app;

CREATE TABLE Profiles (
  id int PRIMARY KEY AUTO_INCREMENT,
  nickname varchar(20) NOT NULL,
  password varchar(20) NOT NULL,
  email varchar(30) NOT NULL,
  comment varchar(500) DEFAULT "Hello",
  icon varchar(100) DEFAULT "static/default_user_icon.png"
);


CREATE TABLE Game_names (
  id int PRIMARY KEY AUTO_INCREMENT,
  game_name varchar(30)
);

CREATE TABLE Games (
  id int PRIMARY KEY AUTO_INCREMENT,
  user_id int NOT NULL,
  game_id int NOT NULL,
  FOREIGN KEY(user_id) REFERENCES Profiles(id),
  FOREIGN KEY(game_id) REFERENCES Game_names(id),
  game_level int DEFAULT 0
);

CREATE TABLE Follows (
  id int PRIMARY KEY AUTO_INCREMENT,
  follow_id int NOT NULL,
  followes_id int NOT NULL,
  FOREIGN KEY(follow_id) REFERENCES Profiles(id),
  FOREIGN KEY(followed_id) REFERENCES Profiles(id)
);

CREATE TABLE Groups (
  id int PRIMARY KEY AUTO_INCREMENT,
  group_name varchar(20),
  group_icon varchar(100)
);

CREATE TABLE Members (
  id int PRIMARY KEY AUTO_INCREMENT,
  member_id int NOT NULL,
  flag_join boolean DEFAULT false,
  group_id int NOT NULL,
  FOREIGN KEY(member_id) REFERENCES Profiles(id),
  FOREIGN KEY(group_id) REFERENCES Groups(id)
);

CREATE TABLE Messages (
  id int PRIMARY KEY AUTO_INCREMENT,
  user_id int NOT NULL,
  group_id int NOT NULL,
  message varchar(500),
  time timestamp,
  FOREIGN KEY(member_id) REFERENCES Profiles(id),
  FOREIGN KEY(group_id) REFERENCES Groups(id)
);

