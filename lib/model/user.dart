import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/model/cartitem.dart';


class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const USERTYPE = "userType";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";


  String _name;
  String _email;
  String _id;
  String _usertype;
  String _stripeId;
  int _priceSum = 0;


//  getters
  String get name => _name;

  String get userType => _usertype;

  String get email => _email;

  String get id => _id;

  String get stripeId => _stripeId;

  // public variables
  List<CartItemModel> cart;
  int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _usertype = snapshot.data[USERTYPE];
    _stripeId = snapshot.data[STRIPE_ID] ?? "";
    cart = _convertCartItems(snapshot.data[CART]?? []);
    totalCartPrice = snapshot.data[CART] == null ? 0 :getTotalPrice(cart: snapshot.data[CART]);
  }

  List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }


  int getTotalPrice({List cart}){
    if(cart == null){
      return 0;
    }
    for(Map cartItem in cart){
      _priceSum += int.parse(cartItem["price"]) * int.parse(cartItem["quantity"]);
    }

    int total = _priceSum;

    return total;
  }



}