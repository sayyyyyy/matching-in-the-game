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
  flag int NOT NULL,
  time_ varchar(15),
  FOREIGN KEY(click_id) REFERENCES Profiles(id),
  FOREIGN KEY(clicked_id) REFERENCES Profiles(id)
);


INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user1", "password", "test1@email.com", "static/images/img1.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user2", "password", "test2@email.com", "static/images/img2.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user3", "password", "test3@email.com", "static/images/img3.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user4", "password", "test4@email.com", "static/images/img4.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user5", "password", "test5@email.com", "static/images/img5.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user6", "password", "test6@email.com", "static/images/img6.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user7", "password", "test7@email.com", "static/images/img7.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user8", "password", "test8@email.com", "static/images/img8.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user9", "password", "test9@email.com", "static/images/img9.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user10", "password", "test10@email.com", "static/images/img10.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user11", "password", "test11@email.com", "static/images/img11.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user12", "password", "test12@email.com", "static/images/img12.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user13", "password", "test13@email.com", "static/images/img13.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user14", "password", "test14@email.com", "static/images/img14.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user15", "password", "test15@email.com", "static/images/img15.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user16", "password", "test16@email.com", "static/images/img16.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user17", "password", "test17@email.com", "static/images/img17.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user18", "password", "test18@email.com", "static/images/img18.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user19", "password", "test19@email.com", "static/images/img19.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user20", "password", "test20@email.com", "static/images/img20.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user21", "password", "test21@email.com", "static/images/img21.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user21", "password", "test22@email.com", "static/images/img22.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user22", "password", "test23@email.com", "static/images/img23.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user23", "password", "test24@email.com", "static/images/img24.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user24", "password", "test25@email.com", "static/images/img25.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user25", "password", "test26@email.com", "static/images/img1.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user26", "password", "test27@email.com", "static/images/img2.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user27", "password", "test28@email.com", "static/images/img3.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user28", "password", "test29@email.com", "static/images/img4.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user29", "password", "test30@email.com", "static/images/img5.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user30", "password", "test31@email.com", "static/images/img6.jpg");
INSERT INTO Profiles (nickname, password, email, icon) VALUES("test_user31", "password", "test32@email.com", "static/images/img7.jpg");


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
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(7, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(7, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(7, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(8, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(8, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(8, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(9, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(9, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(9, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(10, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(10, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(10, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(11, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(11, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(11, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(12, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(12, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(12, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(13, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(13, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(13, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(14, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(14, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(14, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(15, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(15, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(15, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(16, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(16, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(16, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(17, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(17, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(17, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(18, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(18, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(18, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(19, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(19, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(19, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(20, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(20, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(20, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(21, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(21, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(21, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(22, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(22, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(22, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(23, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(23, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(23, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(24, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(24, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(24, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(25, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(25, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(25, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(26, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(26, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(26, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(27, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(27, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(27, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(28, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(28, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(28, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(29, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(29, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(29, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(30, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(30, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(30, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(31, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(31, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(31, 3, 3, 3);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(32, 1, 1, 1);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(32, 2, 2, 2);
INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES(32, 3, 3, 3);

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


-- timeにinsertは無理っぽい
-- INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (0, 24, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 5, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 4, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 12, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (2, 8, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (2, 1, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (2, 3, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (2, 12, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (3, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (3, 4, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (4, 12, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (4, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (5, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (5, 19, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (5, 14, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (6, 9, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (6, 13, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (6, 5, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (7, 15, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (7, 18, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (8, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (9, 17, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (9, 8, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (10, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (11, 28, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (12, 21, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (12, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (13, 23, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (13, 25, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (14, 23, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (15, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (16, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 23, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 22, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 31, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 21, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 18, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (18, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (18, 7, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (18, 20, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (19, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (20, 29, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (20, 10, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (21, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (21, 13, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (22, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (23, 29, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (23, 17, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (23, 19, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (24, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (24, 16, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (25, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (25, 6, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (26, 29, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (26, 21, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (26, 24, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (26, 18, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (27, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (27, 11, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (27, 17, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (28, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (28, 26, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (29, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (29, 30, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (30, 9, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (31, 21, 1, 20201020);


-- こっちはevalで使いたいデータ
-- INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (0, 13, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 3, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (2, 6, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (3, 5, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (4, 13, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (5, 14, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (6, 7, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (7, 13, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (8, 3, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (9, 5, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (10, 13, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (11, 21, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (12, 14, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (13, 14, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (14, 15, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (15, 14, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (16, 18, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 19, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (18, 3, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (19, 19, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (20, 29, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (21, 28, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (22, 28, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (23, 22, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (24, 28, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (25, 24, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (26, 24, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (27, 13, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (28, 28, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (29, 29, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (30, 26, 1, 20201021);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (31, 24, 1, 20201021);
