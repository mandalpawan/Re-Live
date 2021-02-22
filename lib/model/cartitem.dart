
class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const PRICE = "price";
  static const DISCOUNT = "discount";
  static const QUANTITY = "quantity";
  static const DISRIPTION = "quantity";


  String _id;
  String _name;
  String _image;
  String _productId;
  String _price;
  String _discount;
  String _quantity;
  String _discription;


  //  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  String get quantity => _quantity;

  String get discount => _discount;

  String get price => _price;

  String get discription => _discription;



  CartItemModel.fromMap(Map data){
    _id = data[ID];
    _name =  data[NAME];
    _image =  data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _discount = data[DISCOUNT];
    _discription = data[DISRIPTION];
    _quantity = data[QUANTITY];
  }

  Map toMap() => {
    ID: _id,
    IMAGE: _image,
    NAME: _name,
    PRODUCT_ID: _productId,
    PRICE: _price,
    QUANTITY: _quantity,
    DISRIPTION: _discription,
    DISCOUNT: _discount,
  };
}