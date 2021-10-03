from flask import Flask, render_template, request, redirect, session, url_for, jsonify
from datetime import timedelta
import mysql.connector
import re
import MySQLdb.cursors
import flask
import urllib.request
import urllib.parse
import urllib.parse as parse
import json
import base64
from werkzeug.utils import secure_filename
import os
from requests_oauthlib import OAuth1Session

app = Flask(__name__)

# セッション設定
app.secret_key = 'user_id'
app.secret_key = 'profile_id'
app.config['SECRET_KEY'] = b'aaalllaa' # これが暗号化／復号のための鍵になる

# Googleの設定
client_id = ''
client_secret = ''
redirect_uri = ''
state = ''  # 本当はランダム

# Twitterでのログイン認証
api_key = ""
api_secret = ""

# Twitter Endpoint
twitter_base_url = ''
authorization_endpoint = twitter_base_url + ''
request_token_endpoint = twitter_base_url + ''
token_endpoint = twitter_base_url + ''


# ファイルアップロード設定
UPLOAD_FOLDER ='./static/images/'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


@app.route("/")
def main():
  db = mysql.connector.connect(
      user='root',
      password='password',
      host='db',
      database='app'
  )
  cursor = db.cursor(buffered=True)
  cursor.execute("SELECT * FROM Profiles")

  games = db.cursor()
  games.execute("SELECT * FROM Games")

  return render_template("index.html", users=cursor.fetchall(), games=games.fetchall())


@app.route('/login/', methods=['GET', 'POST'])
def login():
  msg = ''
  if request.method == 'POST' and 'nickname' in request.form and 'password' in request.form:
    nickname = request.form['nickname']
    password = request.form['password']
    cnx = mysql.connector.connect(user='root', password='password',
                                  host='db', port='3306', database='app')
    cursor = cnx.cursor()
    cursor.execute('SELECT * FROM Profiles WHERE nickname=%s AND password=%s', (nickname, password))
    account = cursor.fetchone()

    if account:
      session.permanent = True
      app.permanent_session_lifetime = timedelta(minutes=3)
      session.modified = True
      user = request.form['nickname']
      session['user'] = user
      session['loggedin'] = True
      session['user_id'] = account[0]
      return redirect("/main")

    # elif 'user' in session:
    #     return render_template('main.html', session=session['user'])
    #もしこれをコメントアウトしないとログインの記入画面でnicknameとpasswordが間違っていてもmain画面を開いてしまう

    else:
      msg = 'incorrect username or password'

    return render_template("login.html", msg=msg)

  return render_template('login.html')


@app.route('/main')
def main1():
  cnx = mysql.connector.connect(user='root', password='password',
                                host='db', port='3306', database='app')
  cursor = cnx.cursor()
  cursor.execute("SELECT * FROM Profiles WHERE id = %s", (session['user_id'],))
  account = cursor.fetchone()

  return render_template('main.html', session=session['user'], session_id=session['user_id'], account=account, log=session['loggedin'], user=session['user'])

@app.route('/logout')
def logout():
  session.clear()
  return redirect(url_for('login'))

# @app.route("/register", methods=["GET", "POST"])
# def register():
#   """登録フォーム"""
#   if (request.method == "POST"):
#     nickname = request.form.get('nickname')
#     print(nickname)
#     password = request.form.get('password')
#     confirm = request.form.get('confirm')
#     email = request.form.get('email')
#
#     if not nickname:
#         return 'user_nickname is required!'
#     elif not password:
#         return 'user_password is not required!'
#     elif not confirm:
#         return 'user_confirm is not required!'
#     elif not email:
#         return 'user_mail is not required!'
#
#     if password != confirm:
#         return 'Passwords do not match!'
#
#
#     cnx = mysql.connector.connect(user='root', password='password', host='db', port='3306', database='app')
#     cursor = cnx.cursor()
#
# #    account = cursor.fetchone()
# #    if account:
# #            session['loggedin'] = True
# #            session['id'] = account['id']
# #            session['username'] = account['username']
# #      return "Register in successfully"
#
#
#     cursor.execute("INSERT INTO Profiles (nickname, password, email) values (%s, %s, %s)", (nickname, password, email,))
#     cnx.commit()
#   return render_template('register.html')


@app.route('/register2', methods=['GET', 'POST'])
def register2():
  msg = ''
  if request.method == 'POST' and 'nickname' in request.form \
          and 'password' in request.form and 'email' in request.form:
    nickname = request.form['nickname']
    password = request.form['password']
    email = request.form['email']
    db = mysql.connector.connect(user='root', password='password',
                                  host='db', port='3306', database='app')
    cursor = db.cursor()
    cursor.execute('SELECT * FROM Profiles WHERE nickname=%s AND password=%s',
                   (nickname, password))
    account = cursor.fetchone()

    if account:
      return render_template('login.html')

    else:
      cursor = db.cursor()
      cursor.execute("INSERT INTO Profiles (nickname, password, email) values (%s, %s, %s)",(nickname, password, email,))
      db.commit()

      cursor = db.cursor()
      cursor.execute('SELECT * FROM Profiles WHERE nickname=%s AND password=%s',(nickname, password))
      account_new = cursor.fetchone()

      session.permanent = True
      app.permanent_session_lifetime = timedelta(minutes=3)
      session.modified = True
      session['user'] = nickname
      session['loggedin'] = True
      session['user_id'] = account_new[0]

      return render_template('main.html')

  else:
    return render_template('register2.html')


@app.route('/google')
def google():
  return flask.redirect('https://accounts.google.com/o/oauth2/auth?{}'.format(urllib.parse.urlencode({
     'client_id': client_id,
     'scope': 'profile email',
     'redirect_uri': redirect_uri,
     'state': state,
     'openid.realm': 'http://localhost:5000',
     'response_type': 'code'
  })))


@app.route('/login/check')
def check():
  print(flask.request.args.get('state'))
  dat = urllib.request.urlopen('https://www.googleapis.com/oauth2/v4/token', urllib.parse.urlencode({
     'code': flask.request.args.get('code'),
     'client_id': client_id,
     'client_secret': client_secret,
     'redirect_uri': redirect_uri,
     'grant_type': 'authorization_code'
  }).encode('ascii')).read()

  dat = json.loads(dat.decode('ascii'))

  id_token = dat['id_token'].split('.')[1]  # 署名はとりあえず無視する
  id_token = id_token + '=' * (4 - len(id_token)//4)  # パディングが足りなかったりするっぽいので補う
  id_token = base64.b64decode(id_token)
  id_token = json.loads(id_token.decode('ascii'))

  nick_name = id_token['name']
  email = id_token['email']
  password = 'password'

  cnx = mysql.connector.connect(user='root', password='password',
                               host='db', port='3306', database='app')
  cursor = cnx.cursor()
  cursor.execute('SELECT * FROM Profiles WHERE nickname=%s AND email=%s', (nick_name, email,))
  account = cursor.fetchone()


  if account:
     session.permanent = True
     app.permanent_session_lifetime = timedelta(minutes=3)
     session.modified = True
     session['user'] = nick_name
     session['loggedin'] = True
     session['user_id'] = account[0]

     return render_template('main.html')

  else:
     cnx = mysql.connector.connect(user='root', password='password', host='db', database='app')
     cursor = cnx.cursor()
     cursor.execute("INSERT INTO Profiles (nickname, password, email) values (%s, %s, %s)", (nick_name, password, email, ))
     cnx.commit()

     cursor = cnx.cursor()
     cursor.execute('SELECT * FROM Profiles WHERE nickname=%s AND password=%s', (nick_name, password))
     account_new = cursor.fetchone()

     session.permanent = True
     app.permanent_session_lifetime = timedelta(minutes=3)
     session.modified = True
     session['user'] = nick_name
     session['loggedin'] = True
     session['user_id'] = account_new[0]

     return render_template('main.html')



@app.route("/twitter")
def twitter():
   # 1.リクエストトークンを取得する。
   # (Step 1: Obtaining a request token:https://developer.twitter.com/en/docs/authentication/guides/log-in-with-twitter)
   twitter = OAuth1Session(api_key, api_secret)
   oauth_callback = request.args.get('oauth_callback')
   res = twitter.post(request_token_endpoint, params={
       'oauth_callback': oauth_callback})
   request_token = dict(parse.parse_qsl(res.content.decode("utf-8")))
   oauth_token = request_token['oauth_token']

   # 2.リクエストトークンを指定してTwitterへ認可リクエスト(Authorization Request)を行う。
   # (Step 2: Redirecting the user:https://developer.twitter.com/en/docs/authentication/guides/log-in-with-twitter#tab2)
   return redirect(authorization_endpoint+'?{}'.format(parse.urlencode({
       'oauth_token': oauth_token
   })))


@app.route("/callback_twitter")
def callback():
  # 3.ユーザー認証/同意を行い、認可レスポンスを受け取る。
  oauth_verifier = request.args.get('oauth_verifier')
  oauth_token = request.args.get('oauth_token')

  # 4.認可レスポンスを使ってトークンリクエストを行う。
  # (Step 3: Converting the request token to an access token:https://developer.twitter.com/en/docs/authentication/guides/log-in-with-twitter#tab3)
  twitter = OAuth1Session(
     api_key,
     api_secret,
     oauth_token
  )

  res = twitter.post(
     token_endpoint,
     params={'oauth_verifier': oauth_verifier}
  )

  access_token = dict(parse.parse_qsl(res.content.decode("utf-8")))
  # info = jsonify(access_token)
  nick_name = str('initial')
  # nick_name = []
  for i in access_token.values():
     nick_name = i
  password = nick_name
  email = nick_name

  cnx = mysql.connector.connect(user='root', password='password', host='db', database='app')
  cursor = cnx.cursor()
  cursor.execute('SELECT * FROM Profiles WHERE nickname=%s AND email=%s', (nick_name, email))
  account = cursor.fetchone()

  if account:
     session.permanent = True
     app.permanent_session_lifetime = timedelta(minutes=3)
     session.modified = True
     session['user'] = nick_name
     session['loggedin'] = True
     session['user_id'] = account[0]
     return render_template('main.html')

  else:
     cnx = mysql.connector.connect(user='root', password='password', host='db', database='app')
     cursor = cnx.cursor()
     cursor.execute("INSERT INTO Profiles (nickname, password, email) values (%s, %s, %s)", (nick_name, password, email, ))
     cnx.commit()

     cursor = cnx.cursor()
     cursor.execute('SELECT * FROM Profiles WHERE nickname=%s AND email=%s', (nick_name, email))
     account_new = cursor.fetchone()
     session.permanent = True
     app.permanent_session_lifetime = timedelta(minutes=3)
     session.modified = True
     session['user'] = nick_name
     session['loggedin'] = True
     session['user_id'] = account_new[0]
     return render_template('main.html')


@app.route("/profile", methods=["GET", "POST"])
def profile():
    if 'loggedin' in session:
        #session['user_id'] = session['user_id']
        session['profile_id'] = 1

        db = mysql.connector.connect(
        user='root',
        password='password',
        host='db',
        database='app'
        
        )
        if request.method == "POST":
          if request.form.get("follow") == "フォロー":
            user_follow = db.cursor()
            user_follow.execute("INSERT INTO Follows (follow_id, followed_id) VALUES (%s, %s)", (session['user_id'], session['profile_id']))
            db.commit()
          elif request.form.get("unfollow") == "フォローをやめる":
            user_unfollow = db.cursor()
            user_unfollow.execute("DELETE FROM Follows WHERE follow_id = %s AND followed_id = %s", (session['user_id'], session['profile_id']))
          elif request.form.get("talk") == "トーク":
            return "トーク"          
          
          return redirect("/profile")

        else:
            cursor = db.cursor()
            cursor.execute("SELECT * FROM Profiles WHERE id=%s", (session['profile_id'], ))
            user_profile = cursor.fetchall()[0]

            isFollow = db.cursor()
            isFollow.execute("SELECT COUNT(*) FROM Follows WHERE follow_id = %s AND followed_id = %s", (session['user_id'], session['profile_id']))
            isFollow2 = isFollow.fetchall()[0][0]
            
            game_list = db.cursor()
            game_list.execute("SELECT game_id, game_level, game_order FROM Games WHERE user_id = %s", (session['profile_id'],))
            games = game_list.fetchall()

            try:
              star1 = games[0][1]
            except:  
              star1 = 0
            try:
              star2 = games[1][1]
            except:
              star2 = 0
            try:              
              star3 = games[2][1]
            except:
              star3 = 0

            try:
                game1 = db.cursor()
                game1.execute("SELECT game_name FROM Game_names WHERE id = %s", (games[0][0], ))
                game_name1 = game1.fetchall()[0][0]
            except:
                game_name1 = "ゲームが選択されていません"

            try:
                game2 = db.cursor()
                game2.execute("SELECT game_name FROM Game_names WHERE id = %s", (games[1][0], ))
                game_name2 = game2.fetchall()[0][0]
            except:
                game_name2 = "ゲームが選択されていません"

            try:
                game3 = db.cursor()
                game3.execute("SELECT game_name FROM Game_names WHERE id = %s", (games[2][0], ))
                game_name3 = game3.fetchall()[0][0]
            except:
                game_name3 = "ゲームが選択されていません"


            follow = db.cursor()
            follow.execute("SELECT COUNT(*) FROM Follows WHERE follow_id = %s", (session['profile_id'], ))
            follow_count = follow.fetchall()[0][0]

            followed = db.cursor()
            followed.execute("SELECT COUNT(*) FROM Follows WHERE followed_id = %s", (session['profile_id'],))
            followed_count = followed.fetchall()[0][0]

        return render_template("profile.html", user_profile=user_profile,
                               star1=star1, star2=star2, star3=star3, game_name1=game_name1, game_name2=game_name2,
                               game_name3=game_name3, follow_count=follow_count, followed_count=followed_count, isFollow2=isFollow2)

    return redirect(url_for('login'))


@app.route("/edit", methods=["GET", "POST"])
def edit():
    if 'loggedin' in session:
      session['user_id'] = session['user_id']
      db = mysql.connector.connect(
      user='root',
      password='password',
      host='db',
      database='app'
      )

      if request.method == "POST":
        # 画像変更
        #if 'up_file' in request.files:
        if request.form.get("up_file"):
          img_file = request.files['up_file']
          filename = secure_filename(img_file.filename)
          img_url = os.path.join(app.config['UPLOAD_FOLDER'], filename)
          img_file.save(img_url)

          cursor = db.cursor()
          cursor.execute("UPDATE Profiles SET icon = %s WHERE id = %s", (UPLOAD_FOLDER + filename, session['user_id']))
          db.commit()

        # ゲーム変更
        if request.form.get("game1"):
          edit_game1 = db.cursor()
          edit_game1.execute("SELECT id FROM Game_names WHERE game_name = %s", (request.form.get("game1"),))
          game_name_1 = edit_game1.fetchall()[0][0]
          
          set_game1 = db.cursor(buffered=True)
          contain_game1 = db.cursor(buffered=True)
          contain_game1.execute("SELECT * FROM Games WHERE user_id = %s AND game_order = %s", (session['user_id'], 1))
          is_contain1 = contain_game1.fetchall()
          if is_contain1:
            set_game1.execute("UPDATE Games SET game_id = %s WHERE user_id = %s AND game_order = %s", (game_name_1 ,session['user_id'], 1))
          else:
            set_game1.execute("INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES (%s, %s, %s, %s)", (session['user_id'], game_name_1, 1, 1))
          db.commit()

        if request.form.get("skill1"):
          try:
            star1 = db.cursor()
            star1.execute("UPDATE Games SET game_level = %s WHERE user_id = %s AND game_order = %s", (request.form.get("skill1"), session['user_id'], 1))
            db.commit()
          except:
            pass

        if request.form.get("game2"):
          edit_game2 = db.cursor()
          edit_game2.execute("SELECT id FROM Game_names WHERE game_name = %s", (request.form.get("game2"),))
          game_name_2 = edit_game2.fetchall()[0][0]
          
          set_game2 = db.cursor(buffered=True)
          contain_game2 = db.cursor(buffered=True)
          contain_game2.execute("SELECT * FROM Games WHERE user_id = %s AND game_order = %s", (session['user_id'], 2))
          is_contain2 = contain_game2.fetchall()
          if is_contain2:
            set_game2.execute("UPDATE Games SET game_id = %s WHERE user_id = %s AND game_order = %s", (game_name_2 ,session['user_id'], 2))
          else:
            set_game2.execute("INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES (%s, %s, %s, %s)", (session['user_id'], game_name_2, 1, 2))
          db.commit()

        if request.form.get("skill2"):
          try:
            star2 = db.cursor()
            star2.execute("UPDATE Games SET game_level = %s WHERE user_id = %s AND game_order = %s", (request.form.get("skill2"), session['user_id'], 2))
            db.commit()
          except:
            pass

        if request.form.get("game3"):
          edit_game3 = db.cursor(buffered=True)
          edit_game3.execute("SELECT id FROM Game_names WHERE game_name = %s", (request.form.get("game3"),))
          game_name_3 = edit_game3.fetchall()[0][0]

          set_game3 = db.cursor(buffered=True)
          contain_game3 = db.cursor(buffered=True)
          contain_game3.execute("SELECT * FROM Games WHERE user_id = %s AND game_order = %s", (session['user_id'], 3))
          is_contain3 = contain_game3.fetchall()
          if is_contain3:
            set_game3.execute("UPDATE Games SET game_id = %s WHERE user_id = %s AND game_order = %s", (game_name_3 ,session['user_id'], 3))
          else:
            set_game3.execute("INSERT INTO Games (user_id, game_id, game_level, game_order) VALUES (%s, %s, %s, %s)", (session['user_id'], game_name_3, 1, 3))
          db.commit()    

        if request.form.get("skill3"):
          try:
            star3 = db.cursor()
            star3.execute("UPDATE Games SET game_level = %s WHERE user_id = %s AND game_order = %s", (request.form.get("skill3"), session['user_id'], 3))
            db.commit()
          except:
            pass

        # その他変更
        set_prof = db.cursor()
        set_prof.execute("UPDATE Profiles SET nickname = %s, password = %s, email = %s, comment = %s WHERE id = %s", (request.form.get("nickname"), request.form.get("password"), request.form.get("email"), request.form.get("comment"), session['user_id']))
        db.commit()
        return redirect("/edit")
      else:
        cursor = db.cursor()
        cursor.execute("SELECT * FROM Profiles")
        user_profile = cursor.fetchall()[0]

        game_list = db.cursor()
        game_list.execute("SELECT game_name FROM Game_names")
        games = game_list.fetchall()

        game_all = db.cursor()
        game_all.execute("SELECT * FROM Games")
        gameaaa = game_all.fetchall()

        follow = db.cursor()
        follow.execute("SELECT nickname FROM Profiles WHERE id IN (SELECT followed_id FROM Follows WHERE follow_id = %s)", (session['user_id'], ))
        follow_id_list = follow.fetchall()        

        followed = db.cursor()
        followed.execute("SELECT nickname FROM Profiles WHERE id IN (SELECT follow_id FROM Follows WHERE followed_id = %s)", (session['user_id'], ))
        followed_id_list = followed.fetchall()        

        return render_template("edit.html", games=games, user_profile=user_profile, gameaaa=gameaaa, follow_id_list=follow_id_list, followed_id_list=followed_id_list)
    else:
      return redirect(url_for('login'))


if __name__ == '__main__':
  app.run()
