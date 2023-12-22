import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';

class RestaurantResponse {
  bool? error;
  String? message;
  int? count;
  List<Restaurant>? restaurants;

  RestaurantResponse({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}
