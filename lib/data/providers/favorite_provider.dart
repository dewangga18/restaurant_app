import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';
import 'package:restaurant_app/utils/hive/services/restaurant_services.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider() {
    _getData();
  }

  List<Restaurant> savedList = [];

  bool isSavedItem(String? id) {
    for (final item in savedList) {
      if (item.id == id) {
        return true;
      }
    }
    return false;
  }

  void _getData() {
    savedList = RestaurantServices.getRestaurantData();
    notifyListeners();
  }

  void addData(Restaurant data) {
    savedList.add(data);
    notifyListeners();
    RestaurantServices.addRestaurantData(savedList);
  }

  void removeData(Restaurant data) {
    savedList.removeWhere((element) => element.id == data.id);
    notifyListeners();
    RestaurantServices.addRestaurantData(savedList);
  }
}
