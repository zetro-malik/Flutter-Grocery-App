import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grocery_app/model/cart.dart';
import 'package:grocery_app/model/user.dart';
import 'package:grocery_app/screens/home_page.dart';
import 'package:grocery_app/screens/login.dart';
import 'package:grocery_app/widgets/drawer.dart';
import 'package:grocery_app/widgets/drawer.dart';
import 'package:grocery_app/widgets/drawer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:badges/badges.dart' as bd;

import '../screens/cart.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int selectedIndex = 0;
  int badge = 0;
  final padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);
  double gap = 10;

  PageController controller = PageController();

  bool changebtn=false;
  void refresh() async{
    changebtn=true;
    setState(() {});
     await Future.delayed((Duration(milliseconds: 400)));
changebtn=false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: Icon(
              Icons.menu,
              size: 36,
              color: Colors.grey[800],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: IconButton(
              onPressed: () {
               staticUser.obj = null;
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login();
              },));
              },
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.grey[800],
                size: 36,
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ZAM",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 140, 255),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: "galano",
                  ),
                ),
                Text(
                  "Mart",
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: "galano",
                  ),
                ),
                SizedBox(width: 5,),
                Transform.scale(scale: 1.5, child: Icon(Icons.shopping_cart))
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: PageView.builder(
                onPageChanged: (page) {
                  setState(() {
                    selectedIndex = page;
                  });
                },
                controller: controller,
                itemBuilder: (context, position) {
                  if (position == 0) {
                    return HomePage(callback: refresh);
                  }
                 else {
                    return Center(
                      child: Text("No done Yet!"),
                    );
                  }
                },
                itemCount: 3,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 60,
                color: Colors.black.withOpacity(.4),
                offset: Offset(0, 25),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
            child: GNav(
              haptic: true,
              tabs: [
                GButton(
                  gap: gap,
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  gap: gap,
                  text: 'Search',
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.search,
                ),
                 GButton(
                  gap: gap,
                  text: 'Profile',
                  iconSize: 24,
                  padding: padding,
                  icon: Icons.settings,
                ),
                // GButton(
                 
                //   gap: gap,
                //   text: "Cart",
                //   iconSize: 24,
                //   padding: padding,
                //   icon: LineIcons.shoppingCart,
                //   leading: cartItem.cartLst.length == 0
                //       ? null
                //       : Badge(
                //           badgeColor: Color.fromARGB(255, 79, 174, 206),
                //           elevation: 0,
                //           position: BadgePosition.topEnd(top: -12, end: -12),
                //           badgeContent: Text(
                //             cartItem.cartLst.length.toString(),
                //             style: TextStyle(
                //                 color: Color.fromARGB(255, 25, 120, 243)),
                //           ),
                //           child: Icon(
                //             LineIcons.shoppingCart,
                //             color: Colors.black,
                //           ),
                //         ),
                // ),
              ],
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                print(selectedIndex);
                
                setState(() {
                  selectedIndex = index;
                });
                controller.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
      floatingActionButton: AnimatedContainer(
           duration: Duration(milliseconds: 200),
          width: !changebtn ? 50 : 0,
        child: bd.Badge(
          badgeColor: const Color.fromARGB(255, 231, 15, 87),
          borderRadius: BorderRadius.circular(40),
          badgeContent:  Padding(
            padding:EdgeInsets.all(5),
            child: Text(
              cartItem.cartLst.length.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: (){
         Navigator.push(
              context,
              CupertinoPageRoute(builder: (_) => CartPage(callback: refresh,))
                  );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.shopping_cart),
          ),
        ),
      ), 
    );
  }
}
