
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:food_delivery/src/food_notifier.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class frequentlyBought extends StatefulWidget {
  @override
  _frequentlyBoughtState createState() => _frequentlyBoughtState();
}

class _frequentlyBoughtState extends State<frequentlyBought> {

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  int quantity = 1;
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {

    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    void customLaunch(command) async {
      if (await canLaunch(command)) {
        await launch(command);
      } else {
        print(' could not launch $command');
      }
    }

    void launchWhatsApp({@required String phone, @required String message, }) async {
      String url() {
        if (Platform.isIOS) {
          return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
        } else {
          return "whatsapp://send? phone=$phone&text=${Uri.parse(message)}";
        }
      }
      if (await canLaunch(url())) {
        await launch(url());
      } else {
        throw 'Could not launch ${url()}';
      }
    }

    void whatsappmessage(phone) async{
      var whatsappUrl ="whatsapp://send?phone=$phone";
      await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
    }

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.brown,
        elevation: 0.0,
        title: Text(
            foodNotifier.currentFood.title,
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                color: Colors.brown,
                child: Image.network(
                     foodNotifier.currentFood.image == null ?'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg' :
                     foodNotifier.currentFood.image

                ),
              ),
              SizedBox(height: 15.0,),
              Text(
                foodNotifier.currentFood.title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
               foodNotifier.currentFood.Catagory,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                "\u20B9 "+ foodNotifier.currentFood.price,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.brown
                ),
              ),

              SizedBox(height: 10.0,),
              Text(
                foodNotifier.currentFood.discription,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 10.0,),

              GestureDetector(
                onTap: () {
                  customLaunch('tel:+1 555 555 555');
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Call :- 8603587194",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  whatsappmessage('+91 9821049942');

                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text(
                      "Whatsapp :- 8603587194",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  launchWhatsApp(phone: '+91 586522',message: "Hello");
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




















