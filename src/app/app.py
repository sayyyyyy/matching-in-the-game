from flask import Flask, render_template, request, redirect, session, url_for
import mysql.connector
import re
import MySQLdb.cursors
import flask
import urllib.request
import urllib.parse
import json
import base64


app = Flask(__name__)

app.secret_key = ''
client_id = ''
client_secret = ''
redirect_uri = ''
state = ''


@app.route("/")
def main():
    db = mysql.connector.connect(
        user='root',
        password='password',
        host='db',
        database='app'
    )
    cursor = db.cursor()
    cursor.execute("SELECT * FROM user")

    return render_template("index.html", users=cursor.fetchall())


@app.route('/login/', methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        cnx = mysql.connector.connect(user='root', password='password',
                                      host='db', port='3306', database='app')
        cursor = cnx.cursor()
        cursor.execute('SELECT * FROM user WHERE username=%s AND password=%s', (username, password))
        account = cursor.fetchone()
        if account:
#            session['loggedin'] = True
#            session['id'] = account['id']
#            session['username'] = account['username']
            return "logged in successfully"
        else:
            msg = 'incorrecr username or password'

        return render_template("login.html", msg=msg)

    return render_template('login.html')


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


if __name__ == '__main__':
  app.run()