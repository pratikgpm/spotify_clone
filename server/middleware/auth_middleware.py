from fastapi import HTTPException, Header
import jwt


def auth_middleware(x_auth_token = Header()):
    try:
        #get the user token from headers
        if not x_auth_token:
            # 401 code stands for authorization error
            raise HTTPException(401,'No auth token , access denied!')
        
        #decode the token
        # verified_token value is in the form of dictonary
        verified_token =  jwt.decode(x_auth_token,'password_key',['HS256'])

        if not verified_token:
            raise HTTPException(401,'Token Varifivation fail , authorization fail!')
        #get the id from token
        uid = verified_token.get('id')
        return {'uid':uid,'token':x_auth_token}
        #postgress database get the user info
        pass
    except jwt.PyJWTError:
        raise HTTPException(401,'Token is not valid, authorization fail!')