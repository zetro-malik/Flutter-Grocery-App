import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/model/user.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../database/httpAPI.dart/api.dart';
import '../../model/cart.dart';
import '../../model/catalog.dart';

class HomeDetailsPage extends StatefulWidget {
  Function callback;
  final CatalogItem catalog;

   HomeDetailsPage({required this.catalog ,required this.callback});

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  int itemCount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            "\$${(widget.catalog.price*itemCount).toStringAsFixed(2)}".text.bold.xl3.orange600.make(),
            ElevatedButton(
                    onPressed: ()  async{
                  cartItem.cartLst= await API.AddToCart(Cart(uid: staticUser.obj!.ID!, quantity: itemCount, price: double.parse( widget.catalog.price.toStringAsFixed(2)), title: widget.catalog.title));
              
              setState(() {
                itemCount=1;
              });
              widget.callback();
      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                        shape: MaterialStateProperty.all(StadiumBorder())),
                    child: "Add to cart".text.make())
                .wh(120, 50)
          ],
        ).p16(),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Hero(
              tag: Key(widget.catalog.title.toString()),
              child: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/${widget.catalog.imgpath}"),
                  radius: 150),
            ).h32(context),
            Expanded(
              child: VxArc(
                height: 30.0,
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                child: Container(
                  color: context.theme.cardColor,
                  width: context.screenWidth,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: widget.catalog.title.text.xl3
                                .color(Colors.orange[800])
                                .bold
                                .center
                                .make(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 350,
                            child: widget.catalog.description.text.xl
                                .textStyle(context.captionStyle)
                                .center
                                .make(),
                          ),
                          10.heightBox,
                          "Est diam eirmod consetetur et eirmod. Lorem sea sea et nonumy, ut kasd ea ipsum amet sea duo dolor rebum sit. At aliquyam ipsum dolore dolor et takimata eirmod sanctus tempor."
                              .text
                              .textStyle(context.captionStyle)
                              .make()
                              .p16(),
                          SizedBox(
                            height: 40
                          ),
                          Transform.scale(
                            scale: 1.75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (itemCount == 1) return;
                                        itemCount--;
                                      });
                                    },
                                    icon: Icon(Icons.remove)),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  height: 20,
                                  width: 40,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child:
                                      Center(child: Text(itemCount.toString())),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        itemCount++;
                                      });
                                    },
                                    icon: Icon(Icons.add))
                              ],
                            ),
                          ),
                        ]).py64(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
