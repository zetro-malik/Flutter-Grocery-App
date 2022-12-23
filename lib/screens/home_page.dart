// import 'package:grocery_app/tab/burger_tab.dart';
// import 'package:donut_app_ui/tab/donut_tab.dart';
// import 'package:donut_app_ui/tab/pancake_tab.dart';
// import 'package:donut_app_ui/tab/pizza_tab.dart';
// import 'package:donut_app_ui/tab/smoothie_tab.dart';
// import 'package:donut_app_ui/utils/my_tab.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/model/catalog.dart';
import 'package:grocery_app/widgets/titleViews/productTab.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../widgets/my_tab.dart';

class HomePage extends StatefulWidget {
  Function callback;
   HomePage({required this.callback});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState()  {

    if(CatalogItemsByCate.fruitlst.length==0)
      loadData();
    
  }


 
  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final vjson = await rootBundle.loadString("assets/data/products.json");
    final decodeData = jsonDecode(vjson);
   
    CatalogItems.plist =List.from(decodeData).map<CatalogItem>((item) => CatalogItem.fromMap(item)).toList();

    CatalogItems.plist.forEach((element) {
      if(element.type=="dairy"){
      CatalogItemsByCate.dairylst.add(element);
      }
      else  if(element.type=="fruit"){
  CatalogItemsByCate.fruitlst.add(element);
      }
      else  if(element.type=="vegetable"){
  CatalogItemsByCate.veglst.add(element);
      }
      else  if(element.type=="bakery"){
  CatalogItemsByCate.bakerylst.add(element);
      }
      else{
  CatalogItemsByCate.meatlst.add(element);
      }
    });


    
    setState(() {});
  }


  List<Widget> myTabs = const [
    //donut tab
    MyTab(iconPath: "assets/icons/dairy.png"),
    //burger tab
    MyTab(iconPath: "assets/icons/harvest.png"),

    //smoothie
    MyTab(iconPath: "assets/icons/vegetable.png"),

    //pancake tab
    MyTab(iconPath: "assets/icons/bakery.png"),

    //pizza tab
    MyTab(iconPath: "assets/icons/meat.png")
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
      
        body: Column(
          children: [
            // I want to eat
           
          
            const SizedBox(height: 10),
       CatalogItems.plist.length==0?Expanded(child: Center(child: CircularProgressIndicator()))
       : TabBar(tabs: myTabs),

            //tab bar view

        CatalogItems.plist.length!=0?    Expanded(
              child: TabBarView(children: [
                //donut page
                ProductTab(items: CatalogItemsByCate.dairylst, callback: widget.callback),
                //burger page
                 ProductTab(items: CatalogItemsByCate.fruitlst, callback: widget.callback),
                //smoothie page
                ProductTab(items: CatalogItemsByCate.veglst, callback: widget.callback),
                //pancake page
                 ProductTab(items: CatalogItemsByCate.bakerylst, callback: widget.callback),

                //pizza page
                 ProductTab(items: CatalogItemsByCate.meatlst, callback: widget.callback),
              ]),
            ):SizedBox(),
            SizedBox(height: 70,),
        
          ],
        ),
      ),
    );
  }
}
