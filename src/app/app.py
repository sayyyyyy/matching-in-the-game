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
app.config['SECRET_KEY'] = b'aaalllaa' # これが暗号化／復号のための鍵になる

# Googleの設定
client_id = ''
client_secret = ''
redirect_uri = ''
state = ''

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
            return redirect('/top')
            #return render_template('main.html', session=user, session_id=session['user_id'], account=account, log=session['loggedin'], user=user)

        # elif 'user' in session:
        #     return render_template('main.html', session=session['user'])
        #もしこれをコメントアウトしないとログインの記入画面でnicknameとpasswordが間違っていてもmain画面を開いてしまう

        else:
            msg = 'incorrect username or password'

        return render_template("login.html", msg=msg)

    return render_template('login.html')


@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))


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
    return 'success!<br>hello, {}.'.format(id_token['email'])

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

    return jsonify(access_token)


@app.route("/profile", methods=["GET", "POST"])
def profile():
    if 'loggedin' in session:
        session['user_id'] = session['user_id']

        if request.method == "POST":

            db = mysql.connector.connect(
                user ='root',
                password = 'password',
                host ='db',
                database ='app')

            each_id = request.form.get("friend_id")
            cursor = db.cursor()
            cursor.execute("SELECT * FROM Profiles WHERE id=%s", (each_id, ))
            user_profile = cursor.fetchall()[0]
            
            game_list = db.cursor()
            game_list.execute("SELECT game_id, game_level, game_order FROM Games WHERE user_id = %s", (each_id,))
            games = game_list.fetchall()

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
            
            #ログインユーザーじゃないため編集ボタンを表示しないようにする

            user_flag = 1
            return render_template("profile.html", user_profile=user_profile, games=games, game_name1=game_name1, game_name2=game_name2, game_name3=game_name3, user_flag=user_flag)
        else:
            db = mysql.connector.connect(
                user ='root',
                password = 'password',
                host ='db',
                database ='app')
            cursor = db.cursor()
            cursor.execute("SELECT * FROM Profiles WHERE id=%s", (session['user_id'], ))
            user_profile = cursor.fetchall()[0]
            
            game_list = db.cursor()
            game_list.execute("SELECT game_id, game_level, game_order FROM Games WHERE user_id = %s", (session['user_id'],))
            games = game_list.fetchall()

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

        return render_template("profile.html", user_profile=user_profile, games=games, game_name1=game_name1, game_name2=game_name2, game_name3=game_name3)

    return redirect(url_for('login'))


@app.route("/edit", methods=["GET", "POST"])
def edit():
    if 'loggedin' in session:
      session['user_id'] = session['user_id']

      if request.method == "POST":
        db = mysql.connector.connect(
        user ='root',
        password = 'password',
        host ='db',
        database ='app'
        )

        # 画像変更
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
        db = mysql.connector.connect(
        user ='root',
        password = 'password',
        host ='db',
        database ='app'
        )
        cursor = db.cursor()
        cursor.execute("SELECT * FROM Profiles")
        user_profile = cursor.fetchall()[0]

        game_list = db.cursor()
        game_list.execute("SELECT game_name FROM Game_names")
        games = game_list.fetchall()

        game_all = db.cursor()
        game_all.execute("SELECT * FROM Games")
        gameaaa = game_all.fetchall()

        return render_template("edit.html", games=games, user_profile=user_profile, gameaaa=gameaaa)
    else:
      return redirect(url_for('login'))


@app.route("/top", methods=["GET", "POST"])
def top():

   if 'loggedin' in session:
       session['user_id'] = session['user_id']
       
       if request.method == "GET":

          db = mysql.connector.connect(
            user ='root',
            password = 'password',
            host ='db',
            database ='app'
            )
        #相互フォローの友達のアイコントニックネームを表示

        #ログインユーザーがフォローしている人
          follow_id = db.cursor(buffered=True)
          follow_id.execute("SELECT followed_id from Follows where follow_id = %s", (session['user_id'],))
      #ログインユーザーをフォローしている人
          followed_id = db.cursor(buffered=True)
          followed_id.execute("SELECT follow_id from Follows where followed_id = %s", (session['user_id'],))

          follow_f = follow_id.fetchall()
          followed_f = followed_id.fetchall()

          follow_li = [i[0] for i in follow_f]
          
          followed_li = [i[0] for i in followed_f]
        #共通する部分をリスト化
          Mutuals = tuple(set(follow_li) & set(followed_li))
          
          Mutual_friends = []

          for Mutual in Mutuals:
            list_friends = db.cursor(buffered=True)
            list_friends.execute("SELECT icon, nickname, id from Profiles where id = %s", (Mutual,))
            m = list_friends.fetchall()
            Mutual_friends.append(m)

          
          return render_template('top.html', user_id=session['user_id'], Mutuals=Mutuals, Mutual_friends=Mutual_friends)

@app.route("/talk", methods=["GET", "POST"])
def each():
  if 'loggedin' in session:
       session['user_id'] = session['user_id']
       
       if request.method == "POST":

          db = mysql.connector.connect(
                  user ='root',
                  password = 'password',
                  host ='db',
                  database ='app'
                  )

          each_id = request.form.get("talk_id")

          return render_template("talk.html", each_id=each_id, login_user=session['user_id'])

       else:
          return redirect("/")


@app.route('/search', methods=["GET", "POST"])
def search():
  if 'loggedin' in session:
      session['user_id'] = session['user_id']

      if request.method == "GET":
        db = mysql.connector.connect(
                user ='root',
                password = 'password',
                host ='db',
                database ='app'
                )

        game_names = db.cursor(buffered=True)
        game_names.execute("SELECT game_name from Game_names")

        return render_template('search.html', game_names=game_names)

      else:
        if request.form.get("game_name") and request.form.get("game_level"):
          game_name = request.form.get("game_name")
          game_level = request.form.get("game_level")

          db = mysql.connector.connect(
                user ='root',
                password = 'password',
                host ='db',
                database ='app'
                )
          
          game_names = db.cursor(buffered=True)
          game_names.execute("SELECT game_name from Game_names")

          #ゲーム名とレベルで検索し、該当するIDを取得
          game_search = db.cursor(buffered=True)
          game_search.execute("SELECT user_id FROM Games INNER JOIN Game_names on Games.game_id = Game_names.id WHERE game_name = %s AND game_level = %s", (game_name, game_level, ))
          id_search = game_search.fetchall()

          #取得したIDの中でログインユーザーとログインユーザーがフォローしている人のIDを抜き取る
          follow_id = db.cursor(buffered=True)
          follow_id.execute("SELECT followed_id from Follows where follow_id = %s", (session['user_id'],))
          follow_f = follow_id.fetchall()

          id_list = [i[0] for i in id_search]
          follow_list = [i[0] for i in follow_f]
          follow_list.append(session['user_id'])

          results = tuple(set(id_list) - set(follow_list))

          search_result = []

          for result in results:
            game_list = []
            profile_search = db.cursor(buffered=True)
            profile_search.execute("SELECT P.id, P.nickname, P.icon, P.comment from Profiles as P where P.id = %s", (result,))
            p = profile_search.fetchall()
            p = list(p[0])
            
            for i in range(1, 4):

              game_search = db.cursor(buffered=True)
              game_search.execute("SELECT G.game_order, G.game_level, N.Game_name from Games as G INNER JOIN Game_names as N ON G.game_id = N.id where G.user_id = %s and G.game_order = %s", (result, i,))
              g_list = game_search.fetchall()
              g_list = list(g_list[0])

              #search_result.append(g_list)
              for g in g_list:
                p.append(g)
            
            search_result.append(p)

          return render_template('search.html', game_names = game_names, id_search = search_result)


        





if __name__ == '__main__':
  app.run()
