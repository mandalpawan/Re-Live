import 'package:cloud_firestore/cloud_firestore.dart';

class Food{
  String id;
  Timestamp createdAt;
  Timestamp updatedAt;
  String title;
  String price;
  String discount;
  String Catagory;
  String discription;
  String image;
  String sale;

  Food();

  Food.fromMap(Map<String, dynamic> data){
    id = data["id"];
    title = data["title"];
    sale = data["sale"];
    price = data["price"];
    image = data["image"];
    discount = data["discount"];
    Catagory = data["Catagory"];
    discription = data["discription"];
    createdAt = data["createdAt"];
    updatedAt = data["updatedAt"];
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      'title':title,
      'sale': sale,
      'price': price,
      'discount':discount,
      'Catagory': Catagory,
      'discription': discription,
      'image':image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

}



















