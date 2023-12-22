import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/providers/favorite_provider.dart';
import 'package:restaurant_app/data/providers/scheduler_provider.dart';
import 'package:restaurant_app/presentations/screens/detail_page.dart';
import 'package:restaurant_app/presentations/screens/favorite_page.dart';
import 'package:restaurant_app/presentations/screens/home_page.dart';
import 'package:restaurant_app/utils/helpers/background_services.dart';
import 'package:restaurant_app/utils/helpers/notification_helper.dart';
import 'package:restaurant_app/utils/hive/adapter/restaurant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(RestaurantAdapter());
  await Hive.openBox('restaurant-hive');
  await Hive.openBox('schedule');

  final NotificationHelper notificationHelper = NotificationHelper();
   final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
   await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      DetailPage.route,
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoriteProvider>(
          create: (_) => FavoriteProvider(),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
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
