

import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {

  static const ID = "id";
  static const TITLE = "title";
  static const PRICE = "price";
  static const DISCOUNT = "discount";
  static const CATAGORY = "Catagory";
  static const DISCRIPTION = "discription";
  static const IMAGE = "image";
  static const QUANTITY = "quantity";
  static const FOODID = "FoodId";
  static const TOTALPRICE = "totalPrice";


  String _id;
  String _title;
  String _price;
  String _discount;
  String _Catagory;
  String _discription;
  String _image;
  String _quantity;
  String _FoodId;
  String _totalPrice;
  int _priceSum = 0;

  String get id => _id;
  String get title => _title;
  String get price => _price;
  String get discount => _discount;
  String get catagory => _Catagory;
  String get discription => _discription;
  String get image => _image;
  String get quantity => _quantity;
  String get foodid => _FoodId;
  String get totalprice => _totalPrice;

  int TOTALprice;

  CardModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _title = snapshot.data[TITLE];
    _price = snapshot.data[PRICE];
    _discount = snapshot.data[DISCOUNT];
    _Catagory = snapshot.data[CATAGORY];
    _discription = snapshot.data[DISCRIPTION];
    _image = snapshot.data[IMAGE];
    _quantity = snapshot.data[QUANTITY];
    _FoodId = snapshot.data[FOODID];
    _totalPrice = snapshot.data[TOTALPRICE];
    TOTALprice =  getTotalPrice(itemprice: snapshot.data[PRICE],itemquantity : snapshot.data[QUANTITY]);
  }

  int getTotalPrice({String itemprice ,String itemquantity}){
    if(itemquantity == null && itemprice == null){
      return 0;
    }
    _priceSum += int.parse(itemprice) * int.parse(itemquantity);

    int total = _priceSum;

    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");

    return total;
  }











//CardModel({this.price,this.image,this.discription,this.Catagory,this.discount,this.title,this.id,this.quantity,this.FoodId,this.totalPrice});

}