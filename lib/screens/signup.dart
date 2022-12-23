import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/database/httpAPI.dart/api.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/widgets/SignInButton.dart';
import 'package:image_picker/image_picker.dart';

import '../database/local_Database.dart';
import '../model/user.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File? _image;
  String gval="male";


    RegExp regex = RegExp(  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$");
  Future getImage(bool FromCamera) async {
       final ImagePicker _picker = ImagePicker();
       final image = await _picker.pickImage(
        source: FromCamera ? ImageSource.camera : ImageSource.gallery);
    if (image == null) {
      return;
    }
    final tempImg = File(image.path);
    setState(() {
      _image = tempImg;
    });
  }

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  final _formkey = new GlobalKey<FormState>();


  

  String? selectedvalue="Islamabad";
  List<String> countries = ["Islamabad", "RawalPindi", "Karachi", "Lahore"];

  List<DropdownMenuItem<String>> getMenuItems(lst) {
    List<DropdownMenuItem<String>> menulist = [];

    for (int i = 0; i < lst.length; i++) {
      
      DropdownMenuItem<String> item = DropdownMenuItem<String>(
        child: Text(lst[i]),
        value: lst[i],
      );
      menulist.add(item);
    }
    return menulist;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50] ,
      appBar: AppBar(backgroundColor: Colors.orange[600],title: Text("Sign Up", style: TextStyle(fontFamily: "galano"),),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),

          //for validation
          child: Form(
            key: _formkey,

            //to add scroling feature
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //for round profile photo
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        )),
                        builder: (context) => DraggableScrollableSheet(
                            initialChildSize: 0.4,
                            maxChildSize: 0.9,
                            minChildSize: 0.32,
                            expand: false,
                            builder: (context, scrollController) {
                              return SingleChildScrollView(
                                controller: scrollController,
                                child: widgetsInBottomSheet(),
                              );
                            }),
                      );
                    },
                    child: _image == null
                        ? AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                            
                          child: CircleAvatar(
                              backgroundImage: AssetImage("assets/stock_imgs/user.png"),
                              radius:isvalidated? 100:70,
                            ),
                        )
                        : AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          child: CircleAvatar(
                              backgroundImage: FileImage(_image!),
                              radius: isvalidated? 100:70,
                            ),
                        ),
                  ),

                  //text
                
                  SizedBox(height: 20),
                   TextFormField(
                  controller: user,
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

                  //USERNAME textfield
                SizedBox(height: 10,),
                 Row(
                  children: [Text("Gender",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)],
                 ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RadioListTile(title: Text("Male"), value: "male", groupValue: gval, onChanged: (value) {
                          setState(() {
                            gval=value!;
                          });
                        },),
                      ),
                      SizedBox(width: 15),
                       Expanded(
                         child: RadioListTile(title: Text("Female"), value: "female", groupValue: gval, onChanged: (value) {
                          setState(() {
                            gval=value!;
                          });
                                             },),
                       )
                    ],
                  ),
                  DecoratedBox(
                   decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 252, 199, 155), 
              Color.fromARGB(255, 253, 187, 107),
             Color.fromARGB(255, 252, 199, 155),
              //add more colors
            ]),
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 5) //blur radius of shadow
          ]
    ),
                    child: Padding(
                      padding: EdgeInsets.only(left:30, right:30),
                      child:  DropdownButtonHideUnderline(
                        child: DropdownButton(
                            hint: Text('Select Your City', style: TextStyle(fontSize: 15)),
                                     
                                  isExpanded: true,
                                  value: selectedvalue,
                                  items: getMenuItems(countries),
                                  onChanged: (value) {
                                    setState(() {
                                     
                                          selectedvalue = value;
                                    });
                                  }),
                      ),
                    ),
                  ),
SizedBox(height: 20,),
                  //[password] textfield

                    TextFormField(
                  controller: pass,
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
                  SizedBox(height: 20),
                     TextFormField(
                  controller: confirmpass,
                   decoration: new InputDecoration(
                    labelText: "Confrim Password",
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
                        return " empty";
                      } else if (val != pass.text) {
                        return "not matching";
                      } else {
                        return null;
                      }
                  },
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),

                  //confirm password textfield

                
                  SizedBox(height: 20),

                  //ending of textfields

                  //buttons for the screens
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                    color:Colors.orange[800],
                    borderRadius: BorderRadius.circular(changeBtn ? 50 : 8),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: (() => onCreate(context)),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
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
                            : !hideText? Text("Create",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)):CircularProgressIndicator(backgroundColor: Colors.white,color: Colors.orange,),
                      ),
                    ),
                  ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Text("Already have an account?",),
                     SizedBox(width: 5),
                     InkWell(
                      onTap: () {
                       Navigator.pop(context);                      },
                      child:  Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.orange[800]),),
                     )

                  ],
                 )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetsInBottomSheet() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        tipOnBottomSheet(),
        Column(children: [
          const SizedBox(
            height: 100,
          ),
          SignInButton(
            onTap: () {
              getImage(true);
              Navigator.pop(context);
            },
            iconPath: 'assets/logos/camera.png',
            textLabel: 'Take from camera',
            backgroundColor: Colors.grey.shade300,
            elevation: 0.0,
          ),
          const SizedBox(
            height: 40,
          ),
          SignInButton(
            onTap: () {
              getImage(false);
              Navigator.pop(context);
            },
            iconPath: 'assets/logos/gallery.png',
            textLabel: 'Take from gallery',
            backgroundColor: Colors.grey.shade300,
            elevation: 0.0,
          ),
        ])
      ],
    );
  }

  Widget tipOnBottomSheet() {
    return Positioned(
      top: -15,
      child: Container(
        width: 60,
        height: 7,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
      ),
    );
  }

  bool hideText=false;
  bool changeBtn=false;
  bool appydone=false;
  bool crox=false;
  void onCreate(BuildContext context) async {
     if (_formkey.currentState!.validate()) {
       if(_image==null){
        popper(context,"Please Upload image...");
      return;
      }
      isvalidated=true;
      setState(() {
        hideText = true;
        changeBtn=true;
      });
     
      List<int> imageBytes = _image!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      User obj =  User(gender: gval, city: selectedvalue.toString(), email: user.text.trim(), password: pass.text, img: base64Image);

     bool check= await API.InsertUser(obj);
     if(check==false)
      { 
        setState(() {
          crox=true;
          appydone=true;
        });
         await Future.delayed((Duration(milliseconds: 500)));
         popper(context, "Email already has an account");
         setState(() {
           FocusManager.instance.primaryFocus?.unfocus();
          crox=false;
          changeBtn = false;
          appydone = false;
          hideText=false;
         });
        return;
      }

      
      setState(() {
        appydone = true;
      });
      
      await Future.delayed((Duration(milliseconds: 300)));
      Navigator.pop(context);
      setState(() {
        changeBtn = false;
        appydone = false;
      });
     }
     else{
        isvalidated=false;
        setState(() {
          
        });

     }
   
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

  bool isvalidated=true;

}