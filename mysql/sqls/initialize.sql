CREATE DATABASE IF NOT EXISTS app;
USE app;


CREATE TABLE IF NOT EXISTS Profiles(
  id int PRIMARY KEY AUTO_INCREMENT, 
  nickname varchar(20) NOT NULL, 
  password varchar(20) NOT NULL, 
  email varchar(50) NOT NULL, 
  comment varchar(500) DEFAULT "Hello World!", 
  icon varchar(100) DEFAULT "static/default_user_icon.png"
);


CREATE TABLE IF NOT EXISTS Game_names (
  id int PRIMARY KEY AUTO_INCREMENT,
  game_name varchar(30)
);

CREATE TABLE IF NOT EXISTS Games (
  id int PRIMARY KEY AUTO_INCREMENT, 
  user_id int NOT NULL,
  game_id int NOT NULL,
  FOREIGN KEY(user_id) REFERENCES Profiles(id), 
  FOREIGN KEY(game_id) REFERENCES Game_names(id), 
  game_level int DEFAULT 0,
  game_order int DEFAULT 1
);

CREATE TABLE IF NOT EXISTS Follows (
  id int PRIMARY KEY AUTO_INCREMENT, 
  follow_id int NOT NULL,
  followed_id int NOT NULL,
  FOREIGN KEY(follow_id) REFERENCES Profiles(id),
  FOREIGN KEY(followed_id) REFERENCES Profiles(id)
);

CREATE TABLE IF NOT EXISTS Groups (
  id int PRIMARY KEY AUTO_INCREMENT, 
  group_name varchar(100),
  group_icon varchar(100)
);

CREATE TABLE IF NOT EXISTS Members (
  id int PRIMARY KEY AUTO_INCREMENT,
  member_id int NOT NULL,
  flag_join boolean DEFAULT false,
  group_id int NOT NULL,
  FOREIGN KEY(member_id) REFERENCES Profiles(id),
  FOREIGN KEY(group_id) REFERENCES Groups(id)
);

CREATE TABLE IF NOT EXISTS Messages (
  id int PRIMARY KEY AUTO_INCREMENT,
  sender_id int NOT NULL,
  group_id int NOT NULL,
  message varchar(500),
  time timestamp,
  FOREIGN KEY(sender_id) REFERENCES Profiles(id),
  FOREIGN KEY(group_id) REFERENCES Groups(id)
);

INSERT INTO Profiles (nickname, password, email) VALUES("test_user1", "password", "test1@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user2", "password", "test2@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user3", "password", "test3@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user4", "password", "test4@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user5", "password", "test5@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user6", "password", "test6@email.com");

INSERT INTO Game_names (game_name) VALUES("APEX LEGENDS");
INSERT INTO Game_names (game_name) VALUES("Minecraft");
INSERT INTO Game_names (game_name) VALUES("Pokemon");
INSERT INTO Game_names (game_name) VALUES("Fortnite");

INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(1, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(1, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(1, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(2, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(2, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(2, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(3, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(3, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(3, 3, 3, 3);

INSERT INTO Follows (follow_id, followed_id) VALUES(1, 2);
INSERT INTO Follows (follow_id, followed_id) VALUES(2, 1);
