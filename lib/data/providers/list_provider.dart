import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_response.dart';
import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';

enum ResultListState {
  loading,
  error,
  success,
  empty,
}

typedef RestaurantLoader = Future<RestaurantResponse>;

class ListDataProvider extends ChangeNotifier {
  ApiService? apiService;
  RestaurantLoader? loader;

  ListDataProvider({
    this.apiService,
    this.loader,
  }) {
      getRestaurants();
  }

  ResultListState state = ResultListState.empty;

  List<Restaurant> resultData = [];

  Future<void> getRestaurants() async {
    state = ResultListState.loading;
    notifyListeners();

    RestaurantResponse? response;
    if (loader != null) {
      response = await loader!;
    } else if (apiService != null) {
      response = await apiService!.getListData();
    }

    if (response?.restaurants != null) {
      resultData = response?.restaurants ?? [];
      state = ResultListState.success;
    } else if (response?.error ?? false) {
      state = ResultListState.error;
    } else {
      state = ResultListState.empty;
    }
    notifyListeners();
  }
}
