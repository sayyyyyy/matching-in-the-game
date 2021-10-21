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
  group_icon varchar(100),
  flag_group boolean DEFAULT false
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

CREATE TABLE IF NOT EXISTS Clicks (
  id int PRIMARY KEY AUTO_INCREMENT,
  click_id int NOT NULL,
  clicked_id int NOT NULL,
  time timestamp,
  FOREIGN KEY(click_id) REFERENCES Profiles(id),
  FOREIGN KEY(clicked_id) REFERENCES Profiles(id)
);


INSERT INTO Profiles (nickname, password, email) VALUES("test_user1", "password", "test1@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user2", "password", "test2@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user3", "password", "test3@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user4", "password", "test4@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user5", "password", "test5@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user6", "password", "test6@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user7", "password", "test7@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user8", "password", "test8@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user9", "password", "test9@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user10", "password", "test10@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user11", "password", "test11@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user12", "password", "test12@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user13", "password", "test13@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user14", "password", "test14@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user15", "password", "test15@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user16", "password", "test16@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user17", "password", "test17@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user18", "password", "test18@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user19", "password", "test19@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user20", "password", "test20@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user21", "password", "test21@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user22", "password", "test22@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user23", "password", "test23@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user24", "password", "test24@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user25", "password", "test25@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user26", "password", "test26@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user27", "password", "test27@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user28", "password", "test28@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user29", "password", "test29@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user30", "password", "test30@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user31", "password", "test31@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user32", "password", "test32@email.com");


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
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(4, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(4, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(4, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(5, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(5, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(5, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(6, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(6, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(6, 3, 3, 3);

INSERT INTO Follows (follow_id, followed_id) VALUES(1, 2);
INSERT INTO Follows (follow_id, followed_id) VALUES(2, 1);
INSERT INTO Follows (follow_id, followed_id) VALUES(1, 3);
INSERT INTO Follows (follow_id, followed_id) VALUES(3, 1);
INSERT INTO Follows (follow_id, followed_id) VALUES(1, 4);
INSERT INTO Follows (follow_id, followed_id) VALUES(4, 1);
INSERT INTO Follows (follow_id, followed_id) VALUES(1, 5);
INSERT INTO Follows (follow_id, followed_id) VALUES(6, 1);
INSERT INTO Follows (follow_id, followed_id) VALUES(7, 1);
INSERT INTO Follows (follow_id, followed_id) VALUES(8, 1);
INSERT INTO Follows (follow_id, followed_id) VALUES(3, 2);


INSERT INTO Clicks (click_id, clicked_id) VALUES (1, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (1, 5);
INSERT INTO Clicks (click_id, clicked_id) VALUES (1, 4);
INSERT INTO Clicks (click_id, clicked_id) VALUES (1, 12);
INSERT INTO Clicks (click_id, clicked_id) VALUES (1, 27);
INSERT INTO Clicks (click_id, clicked_id) VALUES (2, 8);
INSERT INTO Clicks (click_id, clicked_id) VALUES (2, 12);
INSERT INTO Clicks (click_id, clicked_id) VALUES (3, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (3, 4);
INSERT INTO Clicks (click_id, clicked_id) VALUES (4, 12);
INSERT INTO Clicks (click_id, clicked_id) VALUES (4, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (5, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (5, 19);
INSERT INTO Clicks (click_id, clicked_id) VALUES (6, 9);
INSERT INTO Clicks (click_id, clicked_id) VALUES (6, 13);
INSERT INTO Clicks (click_id, clicked_id) VALUES (7, 15);
INSERT INTO Clicks (click_id, clicked_id) VALUES (7, 18);
INSERT INTO Clicks (click_id, clicked_id) VALUES (8, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (9, 17);
INSERT INTO Clicks (click_id, clicked_id) VALUES (9, 8);
INSERT INTO Clicks (click_id, clicked_id) VALUES (10, 27);
INSERT INTO Clicks (click_id, clicked_id) VALUES (11, 27);
INSERT INTO Clicks (click_id, clicked_id) VALUES (12, 21);
INSERT INTO Clicks (click_id, clicked_id) VALUES (12, 27);
INSERT INTO Clicks (click_id, clicked_id) VALUES (13, 23);
INSERT INTO Clicks (click_id, clicked_id) VALUES (14, 23);
INSERT INTO Clicks (click_id, clicked_id) VALUES (15, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (16, 27);
INSERT INTO Clicks (click_id, clicked_id) VALUES (17, 23);
INSERT INTO Clicks (click_id, clicked_id) VALUES (17, 23);
INSERT INTO Clicks (click_id, clicked_id) VALUES (17, 21);
INSERT INTO Clicks (click_id, clicked_id) VALUES (17, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (17, 18);
INSERT INTO Clicks (click_id, clicked_id) VALUES (18, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (19, 27);
INSERT INTO Clicks (click_id, clicked_id) VALUES (20, 29);
INSERT INTO Clicks (click_id, clicked_id) VALUES (21, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (22, 27);
INSERT INTO Clicks (click_id, clicked_id) VALUES (23, 29);
INSERT INTO Clicks (click_id, clicked_id) VALUES (23, 17);
INSERT INTO Clicks (click_id, clicked_id) VALUES (23, 19);
INSERT INTO Clicks (click_id, clicked_id) VALUES (24, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (25, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (26, 29);
INSERT INTO Clicks (click_id, clicked_id) VALUES (27, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (28, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (29, 2);
INSERT INTO Clicks (click_id, clicked_id) VALUES (30, 9);
INSERT INTO Clicks (click_id, clicked_id) VALUES (31, 21);

