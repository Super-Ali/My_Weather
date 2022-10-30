import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/Api/Fetch_Weather.dart';

import '../Models/weather_data.dart';

class GlobalController extends GetxController {
  // Variable for Use

  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  // Instance for Variables

  RxBool checkLoading() => _isLoading;
  RxDouble latitude() => _latitude;
  RxDouble longitude() => _longitude;

  final weatherData = WeatherData().obs;
  WeatherData getWeatherData() => weatherData.value;

  RxInt getIndex() {
    return _currentIndex;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // Return if service not Enabled
    if (!isServiceEnabled) {
      return Future.error("Location Not Enabled");
    }
    // Status of permission Request
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location Permission is Denied Forever");
    } else if (locationPermission == LocationPermission.denied) {
      // Request Permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Permission is Denied");
      }
    }

    // getting user position
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      // Update Longitude & Latittude
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      // print(_latitude.value);
      // print(_longitude.value);
      // Call weather Api Here
      return FetchWeatherApi()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }
}
