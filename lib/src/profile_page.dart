import 'package:flutter/material.dart';
import 'package:food_delivery/provider/user.dart';


import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool turnonNotification = false;
  bool turnonLocation = false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Profile",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.0,
                          offset: Offset(0,4.0),
                          color: Colors.brown,
                        ),
                      ],
                    ),
                    child: Icon(Icons.person,size: 50.0,color: Colors.white,),
                  ),

                  SizedBox(width: 30.0,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.userModel.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.0,),
                      Text(
                        user.userModel.email.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.0,),

                    ],
                  ),
                ],
              ),

              SizedBox(height: 30.0,),
              Text(
                "Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 15.0),
                elevation: 5.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0,),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.brown,
                            ),
                            SizedBox(width: 15.0,),
                            Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 10.0,color: Colors.grey,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){

                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.visibility,
                                color: Colors.brown,
                              ),
                              SizedBox(width: 15.0,),
                              Text(
                                "Change Password",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 10.0,color: Colors.grey,),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30.0,),
              Text(
                "Notification",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),

              Card(
                margin: EdgeInsets.only(top: 15.0),
                elevation: 5.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "App Notification",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Switch(
                            value: turnonNotification,
                            onChanged: (bool value){
                              setState(() {
                                turnonNotification = value;
                              });
                            },
                          ),
                        ],
                      ),


                      Divider(height: 10.0,color: Colors.grey,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Location Tracing",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Switch(
                            value: turnonLocation,
                            onChanged: (bool value){
                              setState(() {
                                turnonLocation = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.0,),

              GestureDetector(
                onTap: () {
                  user.signOut();
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 25.0),
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text(
                      "Logout",
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
