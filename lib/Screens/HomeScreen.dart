import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Controllers/GlobalControllers.dart';
import 'package:weather_app/Utilities/Custom_Colors.dart';
import 'package:weather_app/Widgets/ComfortLevel_Widget.dart';
import 'package:weather_app/Widgets/CurrentWeather_Widget.dart';
import 'package:weather_app/Widgets/DailyData_Widget.dart';
import 'package:weather_app/Widgets/Header.dart';
import 'package:weather_app/Widgets/HourlyWeather_Widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalController globalController =
        Get.put(GlobalController(), permanent: true);
    return Scaffold(
      body: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/clouds.png",
                        height: 200,
                        width: 200,
                      ),
                      CircularProgressIndicator()
                    ],
                  ),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Header(),
                      CurrentWeatherWidget(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeatherData(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      HourlyDataWidget(
                        weatherDataHourly: globalController
                            .getWeatherData()
                            .getHourlyWeatherData(),
                      ),
                      DailyDataForcast(
                          weatherDataDaily: globalController
                              .getWeatherData()
                              .getDailyWeatherData()),
                      Container(
                        height: 1,
                        color: CustomColors.dividerLine,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ComfortLevelWidget(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeatherData(),
                      )
                    ],
                  ),
                ))),
    );
  }
}
