from flask import url_for,redirect,render_template
from perswebsite import app

@app.route('/')
def home():
  return render_template('index.html')