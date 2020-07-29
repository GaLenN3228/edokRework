import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class MainBloc with ChangeNotifier {
  String address;
  Map<int, int> _cart = new Map();
  int counter = 0;
  int sum = 0;
  int deliveryId;
  String district;
  String orderMinPrice;
  Map filteredPlaces = Map();
  List placeDistricts = List();
  List selectedCategoriesList = List();
  String userPhone;
  String phone;
  String userToken;
  List categoryList = new List();
  List selectedDishesList = new List();
  List cities = List();
  int orderType;
  int activePlacesId;
  Map currentCity = new Map();
  String currentCityId;
  String currentCityName;
  List placesCategories = new List();
  List currentPlaceCategories = new List();
  int currentPlaceId;
  List currentPlaceMenu = List();
  Map<int, int> get cart => _cart;
  List orders;
  int pageId ;
  double amount = 0.0;

  void setUserData(Map user) async {
    final storage = new FlutterSecureStorage();
//    await storage.write(key: 'city', value: currentCity['id']);
//    await storage.write(key: 'city_name', value: currentCity['name_prepositional']);
    await storage.write(key: 'phone', value: this.userPhone);
    await storage.write(key: 'token', value: this.userToken);
  }

  void setDataFromStorage(Map<String, String> storageData) {
    this.currentCityId = storageData['city'];
    this.currentCityName = storageData['city_name'];
    this.userPhone = storageData['phone'];
    this.userToken = storageData['token'];
  }

}
