import 'package:flutter/material.dart';
import 'package:food_delivery/provider/user.dart';
import 'package:food_delivery/src/admin_add_item.dart';

import 'package:provider/provider.dart';

//Pages importing
import 'homepage.dart';

import 'profile_page.dart';

class Main_screen extends StatefulWidget {
  @override
  _Main_screenState createState() => _Main_screenState();
}

class _Main_screenState extends State<Main_screen> {

  int currentTabIndex = 0;

  List<Widget> pages;
  Widget currentPage;

  HomePage homePage;
  AddfooditemAdmin ads;
  Profile profile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePage = HomePage();
    ads = AddfooditemAdmin();
    profile = Profile();
    pages = [homePage,ads,profile];
    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme:  IconThemeData(color: Colors.black),
          title: Text("Re-Live",
            style: TextStyle(
              color: Colors.black,
          ),
          ),
          actions: <Widget>[

            IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            setState(() {
              currentTabIndex = index;
              currentPage = pages[index];
            });
          },
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            /*BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text("Explore"),
            ),*/
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,size: 40.0,),
              title: Text("Ads Post"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
            ),
          ],
        ),

        body: currentPage,
      ),
    );
  }

    Widget _buildShoppingCart(){

      final user = Provider.of<UserProvider>(context);

     return Stack(
       children: <Widget>[
         Icon(Icons.shopping_basket,
           color: Theme.of(context).primaryColor,
         ),

       ],
     );
    }
}
