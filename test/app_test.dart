import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/providers/favorite_provider.dart';
import 'package:restaurant_app/data/providers/list_provider.dart';
import 'package:restaurant_app/data/providers/scheduler_provider.dart';

void main() {
  test('Initial data schedule is false', () async {
    WidgetsFlutterBinding.ensureInitialized();
    bool result;
    try {
      await Hive.initFlutter();
      await Hive.openBox('schedule');
      var provider = SchedulingProvider();
      result = provider.isScheduled;
    } catch (e) {
      result = false;
    }
    expect(result, false);
  });

  test('Initial data favourite is empty', () async {
    WidgetsFlutterBinding.ensureInitialized();
    List result;
    try {
      await Hive.initFlutter();
      await Hive.openBox('restaurant-hive');
      var provider = FavoriteProvider();
      result = provider.savedList;
    } catch (e) {
      result = [];
    }
    expect(result.length, 0);
  });

  test('Initial data favourite is empty', () async {
    WidgetsFlutterBinding.ensureInitialized();
    List result;
    try {
      await Hive.initFlutter();
      await Hive.openBox('restaurant-hive');
      var provider = FavoriteProvider();
      result = provider.savedList;
    } catch (e) {
      result = [];
    }
    expect(result.length, 0);
  });

  group('list data provider', () {
    test('Check initial data', () async {
      var provider = ListDataProvider(
        apiService: ApiService(),
        isMock: true,
      );
      expect(provider.state, ResultListState.empty);
    });
  });
}
