import uuid
import bcrypt
from fastapi import Depends, HTTPException, Header
from models.user import User
from sqlalchemy.orm import joinedload 
from database import get_db
from middleware.auth_middleware import auth_middleware
from pydentic_schema.user_create import userCreate
from pydentic_schema.user_login import Userlogin
from fastapi import APIRouter
from sqlalchemy.orm import Session
import jwt



router = APIRouter()

@router.post('/signup',status_code=201)
def signup_user(user : userCreate,db : Session =Depends(get_db)):
    #extract data thats comming from req
   
    #check if USER ALREADUY exist
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db :  
        raise HTTPException(400,'user with same email id already exists')
    
    
    hashed_pass = bcrypt.hashpw(user.password.encode(),bcrypt.gensalt(16))
    user_db = User(id=str(uuid.uuid4()),email=user.email,password= hashed_pass,name=user.name)
    #add the user in db
    db.add(user_db)
    db.commit()
    db.refresh(user_db)


    return user_db
    
@router.post('/login')
def login_user(user : Userlogin,db:Session = Depends(get_db)):
    #check if the user with same email exist or not if not ask for Signup
    user_db = db.query(User).filter(User.email == user.email).first()
    if not user_db :
        raise HTTPException(400,"User with this Email not exist!")
    
    #password matching or not 
    is_match = bcrypt.checkpw(user.password.encode(),user_db.password)
 
    if not is_match :
        raise HTTPException(400,"Incorrect password!")
    
    token = jwt.encode({'id': user_db.id},'password_key')
    
    return {'token':token , 'user':user_db}

@router.get('/') 
def current_user_data(db: Session= Depends(get_db),user_dict = Depends(auth_middleware)):
    user = db.query(User).filter(User.id == user_dict['uid']).options(joinedload(User.favorites)).first()

    if not user:
        raise HTTPException(404,'User not found!')
    
    return user 

    pass



