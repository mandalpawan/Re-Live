import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/src/card_model.dart';


class CartNotifier with ChangeNotifier{


  List<CardModel> _CardModelList = [];

  CardModel _currentCardModel;

  UnmodifiableListView<CardModel> get CardModelList => UnmodifiableListView(_CardModelList);

  CardModel get currentCardModel => _currentCardModel;

  set CardModelList(List<CardModel> CardModelList) {
    _CardModelList = CardModelList;
    notifyListeners();
  }

  set currentCardModel(CardModel CardModel) {
    _currentCardModel = CardModel;
    notifyListeners();
  }

  addCardModel(CardModel CardModel) {
    _CardModelList.insert(0, CardModel);
    notifyListeners();
  }

  deleteCardModel(CardModel CardModel) {
    _CardModelList.removeWhere((_CardModel) => _CardModel.id == CardModel.id);
    notifyListeners();
  }

}