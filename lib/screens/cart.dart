import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/database/httpAPI.dart/api.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/catalog.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/productCatalog.dart';
import 'package:velocity_x/velocity_x.dart';


class CartPage extends StatefulWidget {
  Function callback;
   CartPage({required this.callback});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    double total=0;
    cartItem.cartLst.forEach((element) {
      total += element.price*element.quantity;
    });

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          backgroundColor: Colors.grey[200],
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        bottomNavigationBar: Container(
          color: context.cardColor,
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              "Total: \$${total.toStringAsFixed(2)}".text.bold.xl2.red800.make(),
              ElevatedButton(
                      onPressed: ()  {
                    
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                          shape: MaterialStateProperty.all(StadiumBorder())),
                      child: "Buy".text.make())
                  .wh(120, 50)
            ],
          ).p16(),
        ),
        backgroundColor: Colors.grey[200],
        body: Container(
          padding: EdgeInsets.all(10),
         
          child: ListView.builder(
                itemCount: cartItem.cartLst.length,
                itemBuilder: (context, index) {
                  
              CatalogItem item=  CatalogItems.plist.where((element) => element.title==cartItem.cartLst[index].title).first;
                  return Card(
                    elevation: 5,
                   
                    child: Padding(
                   padding:EdgeInsets.symmetric(vertical: 30),
                      child: ListTile(
                        leading: CircleAvatar(
                                backgroundImage: AssetImage("assets/images/${item.imgpath}"),
                                radius:50,
                              ),
                        //Text(cartItem.cartLst[index].title,style: TextStyle(fontSize: 16),),
                        title:Column( 
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          
                          Text(cartItem.cartLst[index].title,style: TextStyle(fontSize: 16),),
                           Text("Price: \$"+(cartItem.cartLst[index].price*cartItem.cartLst[index].quantity).toStringAsFixed(2),style: TextStyle(fontSize: 14)),
      
                        ],),
                        subtitle:Text("Quantity: "+cartItem.cartLst[index].quantity.toString(),style: TextStyle(fontSize:14,)) ,
                        //  Row(
                        //   children: [
                           
                        //     SizedBox(width: 5),
                        //     Text(cartItem.cartLst[index].quantity.toString(),style: TextStyle(fontSize: 10))
                        //   ],
                        // ),
      
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: IconButton(onPressed: () async {
                            cartItem.cartLst=await API.delItemFromCart(cartItem.cartLst[index].ID!, staticUser.obj!.ID!);
                            setState(() {
                              
                            });
                            widget.callback();
                          },icon: Icon(Icons.delete),),
                        ),
                  
                      ),
                    ),
                  );          
                }
          ),
        ),
      ),
    );;
  }
}