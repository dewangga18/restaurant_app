import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';

class RestaurantServices {
  static final box = Hive.box('restaurant-hive');
  static const String key = 'restaurant-favorite-items';

  static Future<void> addRestaurantData(
    List<Restaurant> restaurantList,
  ) async {
    box.put(key, restaurantList);
  }

  static List<Restaurant> getRestaurantData() {
    final restaurantList = box.get(key, defaultValue: []);
    return List<Restaurant>.from(restaurantList);
  }
}
