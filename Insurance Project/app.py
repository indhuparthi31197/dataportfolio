from flask import Flask,jsonify,request
from database import Customers, engine,Claims,Policies
from sqlalchemy.orm import sessionmaker
import re


app = Flask(__name__)
Session = sessionmaker(bind=engine)
session = Session()
@app.route('/')
def home():
    return "<h1>Insurance details</h1>"

@app.route("/customers",methods = ["GET"])
def get_all_customers():
    customers_data = session.query(Customers).all()
    res = []
    for itr in customers_data:
        res.append({"id":itr.id,"name":itr.name,"email":itr.email})
    return jsonify(res)

@app.route("/claims",methods = ["GET"])
def get_all_claims():
    claims_data = session.query(Claims).all()
    val = []
    for claim in claims_data:
        val.append({"id":claim.id,"claim_amount":claim.claim_amount,"status":claim.status,"policy_id":claim.policy_id})
    return jsonify(val)
@app.route("/policies",methods = ["GET"])
def get_all_policies():
    policy_data = session.query(Policies).all()
    values = []
    for policy in policy_data:
        values.append({"id":policy.id,
                       "Policy_Info":policy.display_info(),"customer_id":policy.customer_id})
    return jsonify(values)


@app.route("/customers",methods = ["POST"])
def add_new_customers():
    val = request.get_json()
    name = val.get("name")
    email = val.get("email")
    if not re.match(r'[\w\.\-]+@[\w\.\-]+',email):
        return jsonify({"message" :"Email is required","email":email}),400
    new_cust = Customers(name=name,email=email)
    session.add(new_cust)
    session.commit()
    return jsonify({"message":"New Customer added successfully","id": new_cust.id,
        "name": new_cust.name,
        "email": new_cust.email}),201
@app.route("/customers/<int:id>",methods = ["PATCH"])
def update_email(id):
    res = session.query(Customers).filter_by(id = id).first()
    if not res:
        return jsonify({"message":"Invalid User",id:id}),401
    val = request.get_json()
    email = val.get("email")
    if not re.match(r'[\w\.\-]+@[\w\.\-]+',email):
        return jsonify({"message" :"Email is Invalid","email":email}),400
    res.email = val.get("email")
    session.commit()
    return "Email Updated Successfully"
    
@app.route("/claims",methods = ["POST"])
def add_new_claims():
    val = request.get_json()
    claim_amount = val.get("claim_amount")
    status = val.get("status")
    policy_id = val.get("policy_id")
    new_claims = Claims(claim_amount= claim_amount,status = status,policy_id = policy_id)
    session.add(new_claims)
    session.commit()
    return jsonify({
        "message": "Claim added successfully",
        "id": new_claims.id,
        "policy_id": new_claims.policy_id
    }), 201
    
@app.route("/policies",methods = ["POST"])
def add_new_policy():
    pol = request.get_json()
    policy_number = pol.get("policy_number")
    premium = pol.get("premium")
    policy_type = pol.get("policy_type")
    customer_id = pol.get("customer_id")
    new_policy = Policies(policy_number=policy_number,premium=premium,policy_type=policy_type,customer_id=customer_id)
    session.add(new_policy)
    session.commit()
    return jsonify({
        "message": "Policy added successfully",
        "id": new_policy.id,
        "policy_number": new_policy.policy_number
    }), 201

if __name__ == "__main__":
    app.run(debug=True)