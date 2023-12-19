import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/models/restaurant_response.dart';
import 'package:restaurant_app/presentations/screens/detail_page.dart';
import 'package:restaurant_app/presentations/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          titleTextStyle: myTextTheme.apply(bodyColor: Colors.black).titleLarge,
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
      },
    );
  }
}
