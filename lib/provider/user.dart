
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/model/cartitem.dart';
import 'package:food_delivery/model/order.dart';
import 'package:food_delivery/model/product.dart';
import 'package:food_delivery/model/user.dart';
import 'package:food_delivery/services/user.dart';
import 'package:food_delivery/src/food_list_data.dart';
import 'package:uuid/uuid.dart';


enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();

  int _totalSale = 0;
  int _totalprocessingItem = 0;
  int _totalSoldItem = 0;
  int _totalOrderedItem = 0;
  int _totalCancelItem = 0;

  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;

  Status get status => _status;

  FirebaseUser get user => _user;

  int get totalSale => _totalSale;

  int get totalprocessingItem => _totalprocessingItem;

  int get totalSoldItem => _totalSoldItem;

  int get totalOrderedItem => _totalOrderedItem;

  int get totalCancelItem => _totalCancelItem;


  // public variables
  List<OrderModel> orders = [];

  List<OrderModel> ordersAll = [];

  List<UserModel> allUser = [];

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        _userServices.createUser({
          'name': name,
          'email': email,
          'uid': user.user.uid,
          'stripeId': '',
          'userType': 'user'
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void changePassword(String password) async{
    user.updatePassword(password).then((_){
      print("Succesfull changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
    });
  }

  Future<void> _onStateChanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      _status = Status.Authenticated;
      await getTotalSale();
      await getTotalPendingItem();
      await getTotalSoldItem();
      await getTotalOrdered();
      await getTotalCancelItem();
      await getAllUser();
    }
    notifyListeners();
  }

  Future<bool> addToCart(
      {Food product,String quantity}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel> cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.title,
        "image": product.image,
        "productId": product.id,
        "price": product.price,
        "discount": product.discount,
        "discription": product.discription,
        "quantity": quantity,
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
      print("CART ITEMS ARE: ${cart.toString()}");
      _userServices.addToCart(userId: _user.uid, cartItem: item);
//      }

      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> addToCartbySearch(
      {ProductModel  product,String quantity}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel> cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.title,
        "image": product.image,
        "productId": product.id,
        "price": product.price,
        "discount": product.discount,
        "discription": product.discription,
        "quantity": quantity,
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
      print("CART ITEMS ARE: ${cart.toString()}");
      _userServices.addToCart(userId: _user.uid, cartItem: item);
//      }

      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> updateToCard(List cartItem) async {
    try {
      bool itemExists = true;
      if(itemExists) {
        _userServices.updateToCart(userId: _user.uid, cartItem: cartItem);
      }return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromCart({CartItemModel cartItem})async{
    print("THE PRODUC IS: ${cartItem.toString()}");

    try{
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }



  //get total sold price
  getTotalSale() async {
    for(OrderModel order in ordersAll){
      _totalSale = _totalSale + order.total;
    }
    notifyListeners();
  }

  //get total ordered price
  getTotalOrdered() async {
    for(OrderModel order in ordersAll){
      if(order.status == "0"){
        _totalOrderedItem = _totalOrderedItem + 1;
      }
    }

    notifyListeners();
  }

  //get total pending item
  getTotalPendingItem() async {
    for(OrderModel order in ordersAll){
      if(order.status == "50"){
        _totalprocessingItem = _totalprocessingItem + 1;
      }
    }
    notifyListeners();
  }

  //get total sold item
  getTotalSoldItem() async {
    for(OrderModel order in ordersAll){
      if(order.status == "100"){
        _totalSoldItem = _totalSoldItem + 1;
      }
    }
    notifyListeners();
  }

  //get total cancel item
  getTotalCancelItem() async {
    for(OrderModel order in ordersAll){
      if(order.status == "-100"){
        _totalCancelItem = _totalCancelItem + 1;
      }
    }
    notifyListeners();
  }

  getAllUser() async{
    allUser  = await _userServices.getUsers();
  }


  Future<void> reloadUserModel()async{
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }
}













