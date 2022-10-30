import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:weather_app/Screens/HomeScreen.dart';

void main() {
  runApp(Weather_App());
}

class Weather_App extends StatelessWidget {
  const Weather_App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
