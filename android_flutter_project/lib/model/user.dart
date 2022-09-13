class User {
  late final String email;
  late final String password;

  User({required this.email,required this.password});

  User.fromMap(Map<dynamic,dynamic> res)
  :this.email=res['email'],
  this.password=res['password'];

  Map<String,dynamic> toMap(){
      return {
        "email":email,
        "password":password
      };
  }
}