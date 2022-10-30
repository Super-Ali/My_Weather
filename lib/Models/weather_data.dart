import 'package:weather_app/Models/weather_data_current.dart';
import 'package:weather_app/Models/weather_data_daily.dart';
import 'package:weather_app/Models/weather_data_hourly.dart';

class WeatherData {
  WeatherDataCurrent? current;
  WeatherDataHourly? hourly;
  WeatherDataDaily? daily;

  WeatherData([this.current, this.hourly, this.daily]);

  WeatherDataCurrent getCurrentWeatherData() => current!;
  WeatherDataHourly getHourlyWeatherData() => hourly!;
  WeatherDataDaily getDailyWeatherData() => daily!;
}
