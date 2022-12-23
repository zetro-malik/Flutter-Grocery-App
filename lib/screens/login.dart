import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/database/httpAPI.dart/api.dart';
import 'package:grocery_app/database/local_Database.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/productCatalog.dart';
import 'package:grocery_app/screens/signup.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/bottomNavigation.dart';
import '../widgets/textField.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  
    RegExp regex = RegExp(  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$");
   String name = "";
  bool changeBtn = false;
  bool appydone = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hideText=false;
 bool crox=false;
  moveToHome(BuildContext cn) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        hideText = true;
        changeBtn = true;
      });
      dynamic obj1 = await API.checkUser(username.text.trim(), password.text.toString());
     
      if(obj1==false){
       
        setState(() {
          crox=true;
          appydone=true;

        });

       await Future.delayed((Duration(milliseconds: 500)));
        popper(cn,"Incorrect Credentials");
       setState(() {
         FocusManager.instance.primaryFocus?.unfocus();
          crox=false;
          appydone=false;
          changeBtn=false;

        });

        return;
      }
      setState(() {
        appydone = true;
      });
      staticUser.obj=obj1;
       cartItem.cartLst=await API.showCart();
      await Future.delayed((Duration(milliseconds: 500)));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return TabPage();//obj: obj1,);
        },)).then((value) => setState(() {
        FocusManager.instance.primaryFocus?.unfocus();
        changeBtn = false;
        appydone = false;
        hideText=false;
      }));
        
    }
  }

  @override
  Widget build(BuildContext context) {

    return Material(
  
      child: Scaffold(
        backgroundColor: Colors.grey[50] ,
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(children: [
              Image.asset(
                "assets/stock_imgs/a.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text("ZAM",style: TextStyle(color: Color.fromARGB(255, 0, 140, 255), fontSize: 32,
                  fontWeight: FontWeight.bold,
                   fontFamily: "galano",),),
                 Text(
                "Mart",
                style: TextStyle(
                 color: Colors.orange[800],
                
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                   fontFamily: "galano",
                ),
              ),
              ],
             ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                   
                  TextFormField(
                     autofocus: false,
                    controller: username,
                    decoration: new InputDecoration(
                      labelText: "Email",
                        labelStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.white,
                      border:  OutlineInputBorder(
                        borderSide:  BorderSide(),),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 255, 163, 64)),
                      
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (!regex.hasMatch(val!.trim())) {
                        return "Email not valid";
                      } else {
                        return null;
                      }
                    },
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                 
                  TextFormField(
                    autofocus: false,
                    controller: password,
                     decoration: new InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.white,
                      border:  OutlineInputBorder(
                        borderSide:  BorderSide(),),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 255, 163, 64)),
                      
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val!.length == 0) {
                        return "password cannot be empty";
                      } else if (val.length < 8) {
                        return "password length should be greater than 8";
                      } else {
                        return null;
                      }
                    },
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                    const SizedBox(
                      height: 60,
                    ),
                    Material(
                      color:Colors.orange[800],
                      borderRadius: BorderRadius.circular(changeBtn ? 50 : 8),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: (() => moveToHome(context)),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: changeBtn ? 50 : 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: appydone
                              ? !crox? Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ):Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                )
                              :!hideText? Text("Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)):CircularProgressIndicator(backgroundColor: Colors.white,color: Colors.orange,),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       Text("Don't have an account?",),
                       SizedBox(width: 5),
                       InkWell(
                        onTap: () {
                          Navigator.push (
            context,
            CupertinoPageRoute(builder: (_) => SignUp())
                );
                        },
                        child:  Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.orange[800]),),
                       )
                
                    ],
                   )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

    popper(con,text){
    showDialog(
        context: con,
        builder: (con) {
          return Container(
            child: AlertDialog(
              title: Text(text),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(con);
                    },
                    child: Text("OK"))
              ],
            ),
          );
        },
      );
   }





  


}