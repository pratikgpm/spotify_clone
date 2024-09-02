from models.base import Base
from sqlalchemy import VARCHAR, Column, LargeBinary, Text
from sqlalchemy.orm import relationship


class User(Base):
    __tablename__ = "users"

    id = Column(Text,primary_key= True)
    name = Column(VARCHAR(100))
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)

    favorites = relationship('Favorite',back_populates='user')
