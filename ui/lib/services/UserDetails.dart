
class UserDetails{

  static Map _userData;

  // setter
  static void setUserData(String email, String username){
    _userData = {
      "email": email,
      "username": username
    };
    print("---------------------------------------------------------");
    print(_userData);
    print("---------------------------------------------------------");
  }

  // getter
  static Map getUserData(){
    return _userData;
  }

}