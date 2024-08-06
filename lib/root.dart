import 'package:flutter/material.dart';
import 'package:weather/pages/home.dart';
import 'package:weather/pages/splashscreen.dart';
import 'package:weather/routes.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashscreen,
      routes: {
        Routes.splashscreen: (context) => const Splashscreen(),
        Routes.homeScreen: (context) => const HomeScreen(),
      },
    );

  }
}