import 'package:flutter/material.dart';
import 'package:food_delivery/model/product.dart';
import 'package:food_delivery/page/loading.dart';
import 'package:food_delivery/page/search_item.dart';
import 'package:food_delivery/provider/app.dart';
import 'package:food_delivery/provider/user.dart';
import 'package:food_delivery/src/food_notifier.dart';
import 'package:provider/provider.dart';


class searchfoodDetail extends StatefulWidget {
  /*String title;
  String price;
  String discription;
  String id;
  String image;
  String catagory;

  searchfoodDetail({this.title,this.price,this.discription,this.id,this.image,this.catagory});*/

  final ProductModel product;

  const searchfoodDetail({@required this.product});

  @override
  _searchfoodDetailState createState() => _searchfoodDetailState();
}

class _searchfoodDetailState extends State<searchfoodDetail> {

  int quantity = 1;
  int totalPrice = 0;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);


    return Scaffold(
      //key: _scaffoldkey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.orangeAccent,
        elevation: 0.0,
        title: Text(
          widget.product.title,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 150.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.orangeAccent,
                    size: 40.0,
                  ),
                  onPressed: (){
                    setState(() {
                      if(quantity>1 ){
                        quantity -= 1;
                        totalPrice = quantity * int.parse(widget.product.price);
                      }
                    });
                  },
                ),

                SizedBox(width: 15.0,),

                Text(
                  quantity.toString(),
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(width: 15.0,),

                IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.orangeAccent,
                    size: 40.0,
                  ),
                  onPressed: (){
                    setState(() {
                      if(quantity<10){
                        quantity += 1;
                        totalPrice = quantity * int.parse(widget.product.price);
                      }
                    });

                  },
                ),
              ],
            ),

            SizedBox(height: 20.0,),
            FlatButton(
              color: Colors.orangeAccent,
              child: RaisedButton(
                color: Colors.orangeAccent,
                padding: EdgeInsets.symmetric(horizontal: 23.0,vertical: 10.0),
                onPressed: () async {

                  app.changeIsLoading();
                  bool value =  await user.addToCartbySearch(product: widget.product,quantity: quantity.toString());
                  if(value){
                    print("Item added to cart");
                    //_scaffoldkey.currentState.showSnackBar(
                     //   SnackBar(content: Text("Added ro Cart!"))
                    //);
                    user.reloadUserModel();
                    app.changeIsLoading();
                    Navigator.of(context).pop();
                    return;
                  } else{
                    print("Item NOT added to cart");

                  }
                },
                child:app.isLoading ?Loading() : Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.zero,topRight: Radius.zero,bottomLeft: Radius.circular(120),bottomRight: Radius.circular(120)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                color: Colors.orangeAccent,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 5.0,
                      right: 110.0,
                      child: CircleAvatar(
                        maxRadius: (70.0),
                        backgroundImage: NetworkImage(
                            widget.product.image == null ?'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg' :
                            widget.product.image
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              widget.product.title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              widget.product.Catagory,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              "\u20B9 "+ widget.product.price,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 15.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                widget.product.discription,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
