from flask import Flask,render_template,request,session,redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import json
import os,math
from werkzeug.utils import secure_filename

with open('config.json','r') as c:
    params = json.load(c)['params']

app = Flask(__name__)
app.secret_key = 'super secret key'
app.config['UPLOAD_FOLDER'] = params['upload_location']

local_server = True
if(local_server):
   app.config["SQLALCHEMY_DATABASE_URI"] = params['local_uri']
else:
    app.config["SQLALCHEMY_DATABASE_URI"] = params['prod_uri']
db = SQLAlchemy(app)

class Contact(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120),  nullable=False)
    date = db.Column(db.String(12),  nullable=True)
    email = db.Column(db.String(20), nullable=False)
    #email = db.Column(db.String, unique=True nullable=False)

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(50), nullable=False)
    content = db.Column(db.String(400), nullable=False)
    date = db.Column(db.String(12),  nullable=True)
    slug = db.Column(db.String(30), nullable=False)
    img_file = db.Column(db.String(100), nullable=False)
    tagline = db.Column(db.String(30),nullable=False)

@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/ int(params['no_of_posts']))
    #[0:params['no_of_posts']]
    page = request.args.get('page')
    if(not str(page).isnumeric()):
        page = 1
    page = int(page)
    posts = posts[(page-1)*int(params['no_of_posts']) : (page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]

    if(page==1):
        prev = "#"
        next = "/?page=" + str(page+1)
    elif page==last:
        prev = "/?page="+str(page-1)
        next = "#"
    else:
        prev = "/?page=" + str(page-1)
        next = "/?page=" + str(page+1)
    return render_template("index.html",params=params,posts=posts,prev=prev,next=next)

@app.route("/about")
def about():
    return render_template("about.html",params=params)

@app.route("/contact", methods=['GET','POST'])
def contact():
    if(request.method == "POST"):
        name = request.form.get('name')
        phone = request.form.get('phone')
        msg = request.form.get('msg')
        email = request.form.get('email')
        entry = Contact(name=name, phone=phone,msg=msg,date=datetime.now(),email=email)
        db.session.add(entry)
        db.session.commit()
    return render_template("contact.html",params=params)

@app.route("/post/<string:first_post>",methods= ['GET'])
def post_route(first_post):
    post = Posts.query.filter_by(slug=first_post).first()
    return render_template("post.html",params=params,post=post)

@app.route("/delete/<string:sno>",methods=['GET','POST'])
def delete(sno):
    if('user' in session and session['user'] == params['name']):
            post = Posts.query.filter_by(sno=sno).first()
            db.session.delete(post)
            db.session.commit()
    return redirect("/login")
    
@app.route("/edit/<string:sno>",methods=['GET','POST'])
def edit(sno):
    if('user' in session and session['user'] == params['name']):
        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tagline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno=='0':
                post = Posts(title=box_title,content=content,slug=slug,img_file=img_file,tagline=tline,date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.content = content
                post.slug = slug
                post.img_file = img_file
                post.tagline = tline
                post.date = date
                db.session.commit()
                return redirect('/edit/'+sno)
        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html',params=params,post=post)
@app.route("/uploader",methods=['GET','POST'])
def uploader():
    if('user' in session and session['user'] == params['name']):
        if request.method=="POST":
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return "Uploaded Successfully"

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/login')  

@app.route("/login",methods=['GET','POST'])
def login():
    if('user' in session and session['user'] == params['name']):
        posts = Posts.query.all()
        return render_template("dashboard.html",params=params,posts=posts)
    if request.method == "POST":
        username = request.form.get('uname')
        password = request.form.get('upass')
        if( (username == params['name']) and (password == params['pass'])):
            session['user'] = username
            posts = Posts.query.all()
            return render_template("dashboard.html",params=params,posts = posts)
        
    return render_template("login.html",params=params)

app.run(debug=True)