import 'package:flutter/material.dart';
import 'package:food_delivery/page/login.dart';
import 'package:food_delivery/page/spash.dart';
import 'package:food_delivery/provider/app.dart';
import 'package:food_delivery/provider/product.dart';
import 'package:food_delivery/provider/user.dart';

import 'package:food_delivery/src/food_notifier.dart';
import 'package:food_delivery/src/main_screen.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider(
      create: (context) => FoodNotifier(),
    ),
    ChangeNotifierProvider.value(value: ProductProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),

  ], child: MyApp()

  )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.brown
      ),
      home: ScreensController(),
    );
  }
}


class ScreensController extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return   Main_screen() ;
        //return AdminDeshBoard();
      default: return Login();
    }
  }
}

