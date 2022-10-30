import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/Models/weather_data_daily.dart';
import 'package:weather_app/Models/weather_data_hourly.dart';

import '../Models/weather_data.dart';
import '../Models/weather_data_current.dart';

class FetchWeatherApi {
  WeatherData? weatherData;

  // Converting Data From Response to Json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiUrl(lat, lon)));
    var data = await jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(data),
        WeatherDataHourly.fromJson(data), WeatherDataDaily.fromJson(data));
    return weatherData!;
  }
}

String apiUrl(lat, long) {
  String Url;
  Url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&appid=111e76f07e2c48a7d42b3fedbf8f9f4f&units=metric&exclude=minutely";
  return Url;
}
