import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/home_page.dart';
import 'package:restaurant_app/styles.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return HomePage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      body: Hero(
        tag: "splash",
        child: Center(
          child: Text('Restaurant App')
        ),
      ),
    );
  }
}
