import "package:flutter/material.dart";
import 'package:food_delivery/page/search_item.dart';
import 'package:food_delivery/provider/app.dart';
import 'package:food_delivery/provider/product.dart';
import 'package:provider/provider.dart';


class SerchBox extends StatefulWidget {
  @override
  _SerchBoxState createState() => _SerchBoxState();
}

class _SerchBoxState extends State<SerchBox> {
  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      child: TextField(
        autofocus: false,
        textInputAction: TextInputAction.search,
        onSubmitted: (pattern) async {
          app.changeIsLoading();
          productProvider.loadProducts();
          await productProvider.search(productName: pattern);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context){
              return productsearch();
            }
          ));
          app.changeIsLoading();
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 25.0),
          hintText: "What you want to buy ?",
          suffixIcon: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            child: Icon(Icons.search,
              color: Colors.black,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
