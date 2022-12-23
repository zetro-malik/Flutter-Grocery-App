import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/model/catalog.dart';
import 'package:grocery_app/model/user.dart';

class Catalog extends StatefulWidget {
//  User? obj;

//   Catalog({required this.obj});
  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {



  @override
  Widget build(BuildContext context) {
    return Material(child: Scaffold(
      appBar: AppBar(),
      body:CatalogItems.plist.length==0?Center(child: CircularProgressIndicator(),):Text("asdasd"),));
  }



}