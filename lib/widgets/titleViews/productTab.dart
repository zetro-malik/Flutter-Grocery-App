import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/model/catalog.dart';
import 'package:grocery_app/screens/productCatalog.dart';
import 'package:grocery_app/widgets/titleViews/product_tile.dart';

import 'product_detail.dart';

class ProductTab1 extends StatefulWidget {
  List<CatalogItem> items;

  ProductTab1({required this.items});

  @override
  State<ProductTab1> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab1> {
  @override
  Widget build(BuildContext context) {
    return Text("asdsadsa");
    
    // GridView.builder(
    //   padding: const EdgeInsets.all(12.0),
    //   itemCount: widget.items.length,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2, childAspectRatio: 1/1.8 ),
    //   itemBuilder: (context, index) {
    //     return productTile(
    //       title: widget.items[index].title,
    //       prices: widget.items[index].price,
    //       imagename: widget.items[index].imgpath,
    //     );
    //   },
    // );
  }
}

class ProductTab extends StatelessWidget {
  Function callback;
  List<CatalogItem> items;

  ProductTab({required this.items, required this.callback});


 @override
  Widget build(BuildContext context) {
    
  return  GridView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1/1.65 ),
      itemBuilder: (context, index) {
        return InkWell(
           onTap: () { 
            // Navigator.push(
            // context,
            // CupertinoPageRoute(builder: (_) => HomeDetailsPage(catalog: items[index]))
            //     );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => HomeDetailsPage(catalog: items[index], callback:callback)),
                ),
              );
            },
          child: productTile(
            title: items[index].title,
            prices:items[index].price,
            imagename:items[index].imgpath,
            callback:callback
          ),
        );
      },
    );
  }
}