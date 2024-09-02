from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URL = "postgresql://postgres:aaple123@localhost:5432/fluttermusicapp"

#starting point of sqlAlkemyb database make connection
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autoflush=False, autocommit = False,bind= engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
