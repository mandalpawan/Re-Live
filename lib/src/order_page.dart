import 'package:flutter/material.dart';
import 'package:food_delivery/model/cartitem.dart';
import 'package:food_delivery/page/loading.dart';
import 'package:food_delivery/provider/app.dart';
import 'package:food_delivery/provider/user.dart';

import 'package:food_delivery/src/order_adress_form.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);


    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: app.isLoading ? Loading() : user.userModel.totalCartPrice < 1 ?
      Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart,color: Colors.grey,size: 30,),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Text("Your Cart is empty"),
        ],

      )
           : ListView.builder(
          itemCount: user.userModel.cart.length,
          itemBuilder: (_, index) {

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withOpacity(0.2),
                          offset: Offset(3, 2),
                          blurRadius: 30)
                    ]),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      child: Image.network(
                        user.userModel.cart[index].image,
                        height: 120,
                        width: 140,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: user.userModel.cart[index].name+ "\n",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)
                              ),


                              TextSpan(
                                  text: "\u20B9 ${user.userModel.cart[index].price } \n\n",
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold

                                  )
                              ),
                              TextSpan(
                                  text: "Quantity: ",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: user.userModel.cart[index].quantity.toString(),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ]),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: ()async{
                                app.changeIsLoading();
                                bool value = await user.removeFromCart(cartItem: user.userModel.cart[index]);
                                if(value){
                                  user.reloadUserModel();
                                  print("Item added to cart");
                                  _key.currentState.showSnackBar(
                                      SnackBar(content: Text("Removed from Cart!"))
                                  );
                                  app.changeIsLoading();
                                  return;
                                }else{
                                  print("ITEM WAS NOT REMOVED");
                                  app.changeIsLoading();
                                }
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar:(user.userModel.totalCartPrice<1)? null: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: " \u20B9 ${user.userModel.totalCartPrice }",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ]),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.orangeAccent),
                child: FlatButton(
                    onPressed: () {
                      if(user.userModel.totalCartPrice == 0){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)), //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('Your cart is emty', textAlign: TextAlign.center,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0)
                              ), //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('You will be charged \u20B9 ${user.userModel.totalCartPrice} upon delivery!', textAlign: TextAlign.center,),

                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                          /*onPressed: () async{

                                            var uuid = Uuid();
                                            String id = uuid.v4();
                                            _orderServices.createOrder(
                                                userId: user.user.uid,
                                                id: id,
                                                description: "Some random description",
                                                status: "complete",
                                                totalPrice: user.userModel.totalCartPrice,
                                                cart: user.userModel.cart
                                            );
                                            for(CartItemModel cartItem in user.userModel.cart){
                                              bool value = await user.removeFromCart(cartItem: cartItem);
                                              if(value){
                                                user.reloadUserModel();
                                                print("Item added to cart");
                                                _key.currentState.showSnackBar(
                                                    SnackBar(content: Text("Removed from Cart!"))
                                                );
                                              }else{
                                                print("ITEM WAS NOT REMOVED");
                                              }
                                            }
                                            _key.currentState.showSnackBar(
                                                SnackBar(content: Text("Order created!"))
                                            );

                                            Navigator.pop(context);

                                          },*/
                                          onPressed: (){
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (BuildContext context){
                                               //return payment();
                                                return OrderFrom();
                                              }
                                            ));
                                          },
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          color: const Color(0xFF1BC0C5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            color: Colors.red
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      "Check out",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}