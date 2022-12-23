import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/database/httpAPI.dart/api.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/widgets/Tabcolors.dart';
import 'package:grocery_app/widgets/my_tab.dart';

class productTile extends StatefulWidget {
  final String title;
  final double prices;
  final String imagename;
 final Function callback;

  const productTile(
      {super.key,
      required this.title,
      required this.prices,
      required this.imagename,
      required this.callback});

  @override
  State<productTile> createState() => _productTileState();
}

class _productTileState extends State<productTile> {
//tabColors.colors[Random().nextInt(5)][50]
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color:Colors.grey[200] , borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            //price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
               
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                  ),
                  child: Text(
                    "\$" + (widget.prices*itemCount).toStringAsFixed(2).toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.orange[800]),
                  ),
                ),
              ],
            ),
            //picture
          
             
    
          Hero(
            tag: Key(widget.title.toString()),
            child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/${widget.imagename}"),
                                  radius: 60
                                ),
          ),
         

            //falour
            Center(
              child: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            SizedBox(height: 10),

            //icon + button

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                      setState(() {
                        if(itemCount==1)
                        return;
                        itemCount--;
                      });
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.grey[800],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    
                    height: 20,
                    width: 40,
                    color: Colors.grey[300],
                    child: Center(child: Text(itemCount.toString())),
          
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        itemCount++;
                      });
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(onPressed: () async{
             
             
             cartItem.cartLst= await API.AddToCart(Cart(uid: staticUser.obj!.ID!, quantity: itemCount, price: double.parse( widget.prices.toStringAsFixed(2)), title: widget.title));
              
              setState(() {
                itemCount=1;
              });
              widget.callback();
             
            },

            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.orange; //<-- SEE HERE
        return null; // Defer to the widget's default.
      },
    ),
              backgroundColor: MaterialStateProperty.all(Colors.white),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.orange)
    )
  )
), child: Text("Add To Cart", style: TextStyle(color: Colors.orange),))
          ],
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


  int itemCount=1;
}
