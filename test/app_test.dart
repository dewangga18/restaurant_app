import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/models/restaurant_response.dart';
import 'package:restaurant_app/data/providers/list_provider.dart';
import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';

void main() {
  group('list data provider', () {
    late ListDataProvider provider;

    setUp(() {
      provider = ListDataProvider();
    });

    test('Check initial list restaurant is null', () async {
      expect(provider.state, ResultListState.empty);
    });

    test('get list restaurant is success', () async {
      provider = ListDataProvider(loader: mockSuccessLoader());
      await provider.getRestaurants();
      expect(provider.state, ResultListState.success);
    });
  });
}

final mockedData = [
  Restaurant(
    city: 'Surabaya',
    description: 'Restoran dari Surabaya',
    id: '1',
    pictureId: '01',
    name: 'Restoran Surabaya',
    rating: 4.5,
  ),
  Restaurant(
    city: 'Malang',
    description: 'Restoran dari Malang',
    id: '2',
    pictureId: '02',
    name: 'Restoran Malang',
    rating: 4.5,
  ),
];

Future<RestaurantResponse> mockSuccessLoader() async {return Future.value(
      RestaurantResponse(
        count: 2,
        error: false,
        message: 'Success',
        restaurants: mockedData,
      ),
    );}
