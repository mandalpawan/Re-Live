import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/provider/user.dart';
import 'package:provider/provider.dart';
import 'serch_box.dart';
import 'food_list.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    print(user.userModel.userType);

    Widget image_carousal = Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/image1.png'),
          AssetImage('assets/images/image2.png'),
          AssetImage('assets/images/image3.jpg'),
          AssetImage('assets/images/image4.jpg'),
          AssetImage('assets/images/image5.jfif'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
        dotSize: 3.0,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 20.0,right: 20.0),
        children: <Widget>[

          //========Top Most Part ==========================

          //image slider
          image_carousal,

          SizedBox(height: 20.0,),
          //Serch Menu
          SerchBox(),

          //Frenently Bough Item List
          SizedBox(height: 20.0,),

          Bought_item(),


        ],
      ),
    );
  }



}