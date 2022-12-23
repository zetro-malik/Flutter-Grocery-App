import 'dart:convert';


import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/user.dart';
import 'package:http/http.dart' as http;

class API{
static Future<bool> InsertUser(User obj) async {
   var response = await http.post(
    Uri.parse('http://192.168.43.250/groceryApi/api/data/insertUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(obj.toMap()),
  );

  if(response.statusCode == 200){
    return true;
  }
  return false;
}



  static Future<dynamic> checkUser(String email , String pass) async {
  final response = await http
      .get(Uri.parse('http://192.168.43.250/groceryApi/api/data/checkUser?email=${email}&pass=${pass}'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    User obj = User.fromMap(jsonDecode(response.body));
    return obj!;

  } else {
          return false;
  }
}


static Future<List<Cart>> AddToCart(Cart obj) async {
   var response = await http.post(
    Uri.parse('http://192.168.43.250/groceryApi/api/data/AddToCart'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(obj.toMap()),
  );
List<Cart> clist = [];
if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data =jsonDecode(response.body);
   
    for(int i=0;i<data.length;i++){
      clist.add(Cart.fromMap(data[i]));
    }
   
    return clist!;

  } else {
          return clist;
  }
}

static Future<List<Cart>> showCart() async {
  final response = await http
      .get(Uri.parse('http://192.168.43.250/groceryApi/api/data/ShowCart?uid=${staticUser.obj!.ID!}'));
 List<Cart> clist = [];
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data =jsonDecode(response.body);
   
    for(int i=0;i<data.length;i++){
      clist.add(Cart.fromMap(data[i]));
    }
   
    return clist!;

  } else {
          return clist;
  }
}



static Future<List<Cart>> delItemFromCart(int id,int uid) async {
  final response = await http
      .post(Uri.parse('http://192.168.43.250/groceryApi/api/data/delItemFromCart?id=${id}&uid=${uid}'));
 List<Cart> clist = [];
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data =jsonDecode(response.body);
   
    for(int i=0;i<data.length;i++){
      clist.add(Cart.fromMap(data[i]));
    }
   
    return clist!;

  } else {
          return clist;
  }
}



}