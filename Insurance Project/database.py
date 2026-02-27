from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine,Column,Integer,String,Float,ForeignKey
from sqlalchemy.orm import declarative_base,sessionmaker
db = SQLAlchemy()
db_url = "sqlite:///database.db"
engine = create_engine(db_url)
Base = declarative_base()

Session = sessionmaker(bind=engine)
session = Session()

class Customers(Base):
    __tablename__ = "customers"
    id = Column(Integer,primary_key=True)
    name = Column(String)
    email = Column(String,unique=True)
class Policies(Base):
    __tablename__ = "policies"
    id = Column(Integer,primary_key=True)
    policy_number = Column(String,unique = True)
    premium = Column(Float)
    policy_type = Column(String)
    customer_id = Column(Integer,ForeignKey('customers.id'))
    def display_info(self):
        return f"Policy {self.policy_number} ({self.policy_type}) - Premium: {self.premium}"
class Claims(Base):
    __tablename__ = "claims"
    id = Column(Integer,primary_key=True)
    claim_amount = Column(Float)
    status = Column(String)
    policy_id = Column(Integer,ForeignKey('policies.id'))
    

Base.metadata.create_all(engine)
print("Tables Created")



