from database import Claims,Policies,Customers,engine
from sqlalchemy.orm import sessionmaker


Session = sessionmaker(bind=engine)
session = Session()
cust_1 = Customers(name = 'John',email = 'john.doe@mail.com')
cust_2 = Customers(name = 'Alice Lee',email = 'alice.lee@mail.com')
cust_3 = Customers(name = 'Bob Smith',email = 'bob.smith@mail.com')
session.add_all([cust_1,cust_2,cust_3])
session.commit()
policy_1 = Policies(policy_number = 'POL1001',premium= 5000,policy_type='health',customer_id= 1)
policy_2 = Policies(policy_number = 'POL1002',premium= 3000,policy_type='vehicle',customer_id=1)
policy_3 = Policies(policy_number = 'POL1003',premium= 4500,policy_type='health',customer_id=2)
policy_4 = Policies(policy_number = 'POL1004',premium= 3500,policy_type='vehicle',customer_id=3)
session.add_all([policy_1,policy_2,policy_3,policy_4])
session.commit()
claims_1 = Claims(claim_amount= 2000,status ='PENDING',policy_id =1)
claims_2 = Claims(claim_amount=1500,status ='APPROVED',policy_id =2)
claims_3 = Claims(claim_amount=1000,status ='REJECTED',policy_id =3)
session.add_all([claims_1,claims_2,claims_3])
session.commit()