import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';

enum ResultListState {
  loading,
  error,
  success,
  empty,
}

class ListDataProvider extends ChangeNotifier {
  final ApiService apiService;

  ListDataProvider({required this.apiService, bool isMock = false}) {
    if (!isMock) {
      getRestaurants();
    }
  }

  ResultListState state = ResultListState.empty;

  List<Restaurant> resultData = [];

  Future<void> getRestaurants() async {
    state = ResultListState.loading;
    notifyListeners();

    final response = await apiService.getListData();

    if (response.restaurants != null) {
      resultData = response.restaurants ?? [];
      state = ResultListState.success;
    } else if (response.error ?? false) {
      state = ResultListState.error;
    } else {
      state = ResultListState.empty;
    }
    notifyListeners();
  }
}
