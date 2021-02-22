import 'package:cloud_firestore/cloud_firestore.dart';


class ProductModel {
  static const TITLE = "title";
  static const PRICE = "price";
  static const DISCOUNT = "discount";
  static const DISCRIPTION = "discription";
  static const CATAGORY = "Catagory";
  static const PRODUCT_ID = "id";
  static const IMAGE = "image";



  String _title;
  String _price;
  String _discount;
  String _discription;
  String _id;
  String _image;
  String _Catagory;



//  getters
  String get title => _title;

  String get price => _price;

  String get discount => _discount;
  String get discription => _discription;
  String get Catagory => _Catagory;
  String get id => _id;
  String get image => _image;

  // public variables

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _title = snapshot.data[TITLE];
    _price = snapshot.data[PRICE];
    _discount = snapshot.data[DISCOUNT];
    _discription = snapshot.data[DISCRIPTION];
    _Catagory = snapshot.data[CATAGORY];
    _id = snapshot.data[PRODUCT_ID];
    _image = snapshot.data[IMAGE];
  }



}