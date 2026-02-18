from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_restful import Resource,Api,reqparse,fields,marshal_with,abort
import re

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] ='sqlite:///database.db'
api = Api(app)
user_args = reqparse.RequestParser()
user_args.add_argument('name',type = str,required = True,help = 'Name cannot be blank')
user_args.add_argument('email',type = str,required = True,help = 'Email cannot be blank')
user_args.add_argument('phone',type = str,required = True,help = 'Phone cannot be blank')
user_args.add_argument('city',type = str,required = True,help = 'City cannot be blank')
userFields = {'id':fields.Integer,'name':fields.String,'email':fields.String,'phone':fields.String,'city':fields.String}


class Users(Resource):
    @marshal_with(userFields)
    def get(self):
        users = UserModel.query.all()
        return users
    @marshal_with(userFields)
    def post(self):
        args = user_args.parse_args()
        if not re.match(r'[\w\.\-]+@[\w\.\-]+',args["email"]):
            abort(400,message= "Invalid Email")
        user = UserModel(name = args["name"],email = args["email"],phone = args["phone"],city = args["city"])
        db.session.add(user)
        db.session.commit()
        users = UserModel.query.all()
        return users, 201
class User(Resource):
    @marshal_with(userFields)
    def get(self,id):
        user = UserModel.query.filter_by(id  = id).first()
        if not user:
            abort(404,"User not found")
        return user
    @marshal_with(userFields)    
    def patch(self,id):
        args = user_args.parse_args()
        user = UserModel.query.filter_by(id  = id).first()
        if not user:
            abort(404,"User not found")
        user.name = args["name"]
        if not re.match(r'[\w\.\-]+@[\w\.\-]+',args["email"]):
            abort(400,message= "Invalid Email")
        user.email = args["email"]
        
        user.phone = args["phone"]
        user.city = args["city"]
        db.session.commit()
        return user
    @marshal_with(userFields)
    def delete(self,id):
        
        user = UserModel.query.filter_by(id  = id).first()
        if not user:
            abort(404,"User not found")
        
        db.session.delete(user)
        db.session.commit()
        return user,204
api.add_resource(Users,'/api/users/')
api.add_resource(User,'/api/users/<int:id>')
db = SQLAlchemy(app)

class UserModel(db.Model):
    id = db.Column(db.Integer,primary_key = True)
    name= db.Column(db.String(80),nullable = False)
    email= db.Column(db.String(80),unique = True,nullable = False)
    phone = db.Column(db.String(50),nullable= False)
    city = db.Column(db.String(60),nullable = False)

    def __repr__(self):
        return f"(Username:{self.name}),email:{self.email},phone:{self.phone},city:{self.city})"
@app.route('/')
def home():
    return "<h1>Welcome to RestAPI practice </h1>"
if __name__ =='__main__':
    app.run(debug = True)
