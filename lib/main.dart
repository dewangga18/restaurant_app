import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/providers/favorite_provider.dart';
import 'package:restaurant_app/presentations/screens/detail_page.dart';
import 'package:restaurant_app/presentations/screens/favorite_page.dart';
import 'package:restaurant_app/presentations/screens/home_page.dart';
import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(RestaurantAdapter());
  await Hive.openBox('restaurant-hive');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
              ),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(
            elevation: 0,
            toolbarTextStyle:
                myTextTheme.apply(bodyColor: Colors.black).bodyMedium,
            titleTextStyle:
                myTextTheme.apply(bodyColor: Colors.black).titleLarge,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: secondaryColor,
            unselectedItemColor: Colors.grey,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: secondaryColor,
              textStyle: const TextStyle(fontSize: 15),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
        ),
        initialRoute: HomePage.route,
        routes: {
          HomePage.route: (_) => const HomePage(),
          DetailPage.route: (context) => DetailPage(
                data: ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          FavoritePage.route: (_) => const FavoritePage(),
        },
      ),
    );
  }
}
