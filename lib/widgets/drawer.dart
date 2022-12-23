import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/model/user.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  final imgurl =
      "https://i.pinimg.com/736x/62/2f/9d/622f9d0cfaf3bdd69fba4046103363e2.jpg";

  @override
  Widget build(BuildContext context) {
    var image = base64Decode(staticUser.obj!.img);
     
     
    return Drawer(
      backgroundColor:Colors.orange[300],
      child: ListView(
        children: [
          
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.orange[500]),
              margin: EdgeInsets.zero,
              accountName:  Text(staticUser.obj!.email),
              accountEmail:  Text(staticUser.obj!.city),
              currentAccountPicture:
                  CircleAvatar(backgroundImage: MemoryImage(image),),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.white,
              size: 25,
            ),
            title: Text(
              "Home",
              style: TextStyle(color: Colors.white),
              textScaleFactor: 1.2,
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.white,
              size: 25,
            ),
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.white),
              textScaleFactor: 1.2,
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.mail,
              color: Colors.white,
              size: 25,
            ),
            title: Text(
              "Email me",
              style: TextStyle(color: Colors.white),
              textScaleFactor: 1.2,
            ),
          )
        ],
      ),
    );
  }
}
