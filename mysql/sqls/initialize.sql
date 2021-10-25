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


INSERT INTO Profiles (nickname, password, email) VALUES("test_user1", "password", "test1@email.com");
INSERT INTO Profiles (nickname, password, email) VALUES("test_user2", "password", "test2@email.com");

INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("よきみ", "password", "test33@email.com", "初心者です。よろしくお願いします。", "static/images/img1.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("へけこ", "password", "test34@email.com", "スマブラやってます。", "static/images/img2.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("いこね", "password", "test35@email.com", "みんなでワイワイやりたいです。よろしくお願いします。", "static/images/img3.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("いきお", "password", "test36@email.com", "一緒に楽しみましょう！", "static/images/img4.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("るすと", "password", "test37@email.com", "一緒にやってくれる方募集", "static/images/img5.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("エワト", "password", "test38@email.com", "Apexやってます。", "static/images/img6.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("ヨシノ", "password", "test39@email.com", "よろしくお願いします。", "static/images/img7.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("ウシライ", "password", "test40@email.com", "色々やってます。", "static/images/img8.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("アイオラ", "password", "test41@email.com", "FPS色々やってます", "static/images/img9.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("タンジン", "password", "test42@email.com", "よろしくお願いします。", "static/images/img10.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("ユウノガ", "password", "test11@email.com", "RPG好きです。", "static/images/img11.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("テテタヤ", "password", "test11@email.com", "よろしくお願いします。", "static/images/img12.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("カルルク", "password", "test11@email.com", "楽しみながらやりたいです。", "static/images/img13.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("paca", "password", "test11@email.com", "よろしくお願いします。", "static/images/img14.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("shor", "password", "test11@email.com", "交友関係を広げたいです。よろしくお願いします。", "static/images/img15.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("hide", "password", "test11@email.com", "色んなゲームやってます", "static/images/img16.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("たいやき", "password", "test11@email.com", "よろしくお願いします。", "static/images/img17.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("soda", "password", "test11@email.com", "よろしくお願いします。", "static/images/img18.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("sora", "password", "test11@email.com", "よろしくお願いします。", "static/images/img19.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("aiko", "password", "test11@email.com", "よろしくお願いします。", "static/images/img20.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("エン", "password", "test11@email.com", "よろしくお願いします。", "static/images/img21.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("ロッキー", "password", "test11@email.com", "あまりゲームやってないですが、よろしくお願いします。", "static/images/img22.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("マイク", "password", "test11@email.com", "一緒に頑張りましょう", "static/images/img23.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("らん", "password", "test11@email.com", "初心者ですがよろしく", "static/images/img24.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("ファミ", "password", "test11@email.com", "一緒にやりましょう！", "static/images/img25.jpg");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("roid", "password", "test11@email.com", "よろしくお願いします", "static/default_user_icon.png");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("ゆき", "password", "test11@email.com", "よろしくお願いします", "static/default_user_icon.png");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("kemu", "password", "test11@email.com", "よろしくお願いします", "static/default_user_icon.png");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("レン", "password", "test11@email.com", "よろしくお願いします", "static/default_user_icon.png");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("ユノ", "password", "test11@email.com", "よろしくお願いします", "static/default_user_icon.png");
INSERT INTO Profiles (nickname, password, email, comment, icon) VALUES("アキ", "password", "test11@email.com", "よろしくお願いします", "static/default_user_icon.png");



INSERT INTO Game_names (game_name) VALUES("APEX LEGENDS");
INSERT INTO Game_names (game_name) VALUES("Minecraft");
INSERT INTO Game_names (game_name) VALUES("Pokemon");
INSERT INTO Game_names (game_name) VALUES("Fortnite");
INSERT INTO Game_names (game_name) VALUES("League of Legends");
INSERT INTO Game_names (game_name) VALUES("ARK: Survival Evolved");
INSERT INTO Game_names (game_name) VALUES("Tom Clancy's Rainbow Six Siege");
INSERT INTO Game_names (game_name) VALUES("PLAYERUNKNOWN'S BATTLEGROUNDS");
INSERT INTO Game_names (game_name) VALUES("Watch Dogs");
INSERT INTO Game_names (game_name) VALUES("Dead by Daylight");
INSERT INTO Game_names (game_name) VALUES("DARK SOULS");
INSERT INTO Game_names (game_name) VALUES("Counter-Strike");
INSERT INTO Game_names (game_name) VALUES("Grand Theft Auto");
INSERT INTO Game_names (game_name) VALUES("Battlefield");
INSERT INTO Game_names (game_name) VALUES("Monster Hunter");
INSERT INTO Game_names (game_name) VALUES("THE CREW");
INSERT INTO Game_names (game_name) VALUES("ドラゴンクエスト");
INSERT INTO Game_names (game_name) VALUES("ファイナルファンタジー");
INSERT INTO Game_names (game_name) VALUES("Among Us");
INSERT INTO Game_names (game_name) VALUES("桃太郎電鉄");
INSERT INTO Game_names (game_name) VALUES("HUMAN fall flat");
INSERT INTO Game_names (game_name) VALUES("大乱闘スマッシュブラザーズ");
INSERT INTO Game_names (game_name) VALUES("マリオカート");
INSERT INTO Game_names (game_name) VALUES("スプラトゥーン");
INSERT INTO Game_names (game_name) VALUES("ゼルダの伝説");
INSERT INTO Game_names (game_name) VALUES("どうぶつの森");
INSERT INTO Game_names (game_name) VALUES("FIFA");
INSERT INTO Game_names (game_name) VALUES("荒野行動");
INSERT INTO Game_names (game_name) VALUES("Pokemon Unite");
INSERT INTO Game_names (game_name) VALUES("Identity Ⅴ");
INSERT INTO Game_names (game_name) VALUES("太鼓の達人");
INSERT INTO Game_names (game_name) VALUES("モンスターストライク");
INSERT INTO Game_names (game_name) VALUES("Call of Duty");
INSERT INTO Game_names (game_name) VALUES("クラッシュ・ロワイヤル");
INSERT INTO Game_names (game_name) VALUES("アークナイツ");
INSERT INTO Game_names (game_name) VALUES("パズル＆ドラゴンズ");
INSERT INTO Game_names (game_name) VALUES("プロ野球スピリッツ");
INSERT INTO Game_names (game_name) VALUES("原神");
INSERT INTO Game_names (game_name) VALUES("Pokemon GO");
INSERT INTO Game_names (game_name) VALUES("Fate/Grand Order");
INSERT INTO Game_names (game_name) VALUES("ウマ娘　プリティーダービー");
INSERT INTO Game_names (game_name) VALUES("サマナーズウォー: Sky Arena");
INSERT INTO Game_names (game_name) VALUES("にゃんこ大戦争");


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
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 5, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 4, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 12, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (1, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (2, 8, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (2, 12, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (3, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (3, 4, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (4, 12, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (4, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (5, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (5, 19, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (6, 9, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (6, 13, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (7, 15, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (7, 18, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (8, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (9, 17, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (9, 8, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (10, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (11, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (12, 21, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (12, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (13, 23, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (14, 23, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (15, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (16, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 23, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 23, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 21, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (17, 18, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (18, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (19, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (20, 29, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (21, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (22, 27, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (23, 29, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (23, 17, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (23, 19, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (24, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (25, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (26, 29, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (27, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (28, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (29, 2, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (30, 9, 1, 20201020);
INSERT INTO Clicks (click_id, clicked_id, flag, time_) VALUES (31, 21, 1, 20201020);


-- こっちはevalで使いたいデータ
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