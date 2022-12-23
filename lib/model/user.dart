class staticUser{
  static User? obj ;
}

class User{
   int? ID;
  String email;
  String gender;
  String city;
  String password;
  String img;

  User({this.ID, required this.gender,required this.city,required this.email, required this.password,required this.img});

  static fromMap(Map<String, dynamic> map) {
    User a = User(
      ID: map["id"],
      email: map["email"],
          gender: map["gender"],
      city: map["city"],
      password: map["password"],
      img: map["img"]

    );
    return a;
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': this.ID,
      'email': this.email,
      'gender':this.gender,
      "city":this.city,
      'password': this.password,
      "img":this.img
      

    };
  }
}