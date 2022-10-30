import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Controllers/GlobalControllers.dart';
import 'package:weather_app/Models/weather_data_hourly.dart';
import 'package:weather_app/Utilities/Custom_Colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  RxInt cardIndex = GlobalController().getIndex();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: const Text("Today", style: TextStyle(fontSize: 18))),
        hourlyList()
      ],
    );
  }

  Widget hourlyList() {
    return Container(
        height: 130,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weatherDataHourly.hourly.length > 12
                ? 20
                : weatherDataHourly.hourly.length,
            itemBuilder: (context, index) {
              return Obx(
                () => GestureDetector(
                    onTap: () {
                      cardIndex.value = index;
                    },
                    child: Container(
                        width: 80,
                        margin: EdgeInsets.only(left: 20, right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0.5, 0),
                                  blurRadius: 30,
                                  spreadRadius: 1,
                                  color:
                                      CustomColors.dividerLine.withAlpha(150))
                            ],
                            gradient: cardIndex.value == index
                                ? const LinearGradient(colors: [
                                    CustomColors.firstGradientColor,
                                    CustomColors.secondGradientColor
                                  ])
                                : null),
                        child: HourlyDetails(
                          index: index,
                          cardIndex: cardIndex.value,
                          temp: weatherDataHourly.hourly[index].temp!,
                          timeStamp: weatherDataHourly.hourly[index].dt!,
                          weatherIcon:
                              weatherDataHourly.hourly[index].weather![0].icon!,
                        ))),
              );
            }));
  }
}

class HourlyDetails extends StatelessWidget {
  double temp;
  int timeStamp;
  String weatherIcon;
  int index;
  int cardIndex;

  HourlyDetails(
      {Key? key,
      required this.index,
      required this.cardIndex,
      required this.temp,
      required this.timeStamp,
      required this.weatherIcon})
      : super(key: key);

  String getTime(timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    int nTemp;
    nTemp = temp.round();
    return Column(children: [
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  getTime(timeStamp),
                  style: TextStyle(
                      color: cardIndex == index ? Colors.white : Colors.black),
                )),
            Container(
              margin: EdgeInsets.all(5),
              child: Image.asset(
                "assets/weather/${weatherIcon}.png",
                height: 40,
                width: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text("${nTemp}°",
                  style: TextStyle(
                      color: cardIndex == index ? Colors.white : Colors.black)),
            )
          ],
        ),
      )
    ]);
  }
}
