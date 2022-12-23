

import 'package:grocery_app/model/user.dart';

class cartItem{
 static  List<Cart> cartLst=[];
}

class Cart{
  int? ID;
  int uid;
  String title;
  int quantity;
  double price;


  Cart({this.ID,required this.uid ,required this.quantity,required this.price,required this.title});

  static fromMap(Map<String, dynamic> map) {
    Cart a =Cart(ID: map["id"], uid: map["uid"], quantity: map["quantity"], price: map["price"], title: map["title"]);
    return a;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.ID,
      'uid':staticUser.obj!.ID!,
      'title': this.title,
      'quantity':this.quantity,
      "price":this.price,
    };
  }
}