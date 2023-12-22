import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';

enum SearchState {
  loading,
  error,
  success,
  empty,
}

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService}) {
    doSearchData('');
  }

  @override
  void dispose() {
    focusNode.dispose();
    txtController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  bool _isSearch = false;
  FocusNode focusNode = FocusNode();
  TextEditingController txtController = TextEditingController();

  bool get isSearch => _isSearch;

  void hideSearch() {
    _isSearch = false;
    notifyListeners();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void displaySearch() {
    state = SearchState.success;
    searchData = initData;
    _isSearch = true;
    notifyListeners();
    txtController.clear();
    focusNode.requestFocus();
  }

  void clearText() {
    searchData = initData;
    notifyListeners();
    txtController.clear();
  }

  Timer? _timer;

  void onChanged(String? value) {
    state = SearchState.loading;
    notifyListeners();
    if (value == null) {
      return;
    }
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(
      const Duration(milliseconds: 1000),
      () => doSearchData(value),
    );
  }

  List<Restaurant> searchData = [];
  List<Restaurant> initData = [];
  SearchState state = SearchState.success;

  Future<void> doSearchData(String query) async {
    final response = await apiService.searchData(query);
    if (response.error == true) {
      state = SearchState.error;
    } else if (response.restaurants == null ||
        (response.restaurants?.isEmpty ?? true)) {
      state = SearchState.empty;
    } else {
      state = SearchState.success;
      if (initData.isEmpty) {
        initData = response.restaurants!;
      }
      searchData = response.restaurants!;
    }
    notifyListeners();
  }
}
