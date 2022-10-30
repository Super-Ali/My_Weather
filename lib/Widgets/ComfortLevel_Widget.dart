import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app/Models/weather_data_current.dart';
import 'package:weather_app/Utilities/Custom_Colors.dart';

class ComfortLevelWidget extends StatelessWidget {
  WeatherDataCurrent weatherDataCurrent;
  ComfortLevelWidget({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
          child: const Text(
            "Comfort Level",
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
            height: 180,
            child: Column(
              children: [
                Center(
                  child: SleekCircularSlider(
                    min: 0,
                    max: 100,
                    initialValue:
                        weatherDataCurrent.current.humidity!.toDouble(),
                    appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                            handlerSize: 0,
                            trackWidth: 12,
                            progressBarWidth: 12),
                        infoProperties: InfoProperties(
                            bottomLabelText: "Humidity",
                            bottomLabelStyle: const TextStyle(
                                letterSpacing: .1, fontSize: 14, height: 1.5)),
                        animationEnabled: true,
                        size: 140,
                        customColors: CustomSliderColors(
                            hideShadow: true,
                            trackColor:
                                CustomColors.firstGradientColor.withAlpha(100),
                            progressBarColors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor
                            ])),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "Feels Like : ",
                          style: TextStyle(
                              fontSize: 14,
                              height: .8,
                              color: CustomColors.textColorBlack,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: "${weatherDataCurrent.current.feelslike}",
                          style: const TextStyle(
                              fontSize: 14,
                              height: .8,
                              color: CustomColors.textColorBlack,
                              fontWeight: FontWeight.w400))
                    ])),
                    Container(
                      width: 1,
                      height: 25,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      color: CustomColors.dividerLine,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "UV Index : ",
                          style: TextStyle(
                              fontSize: 14,
                              height: .8,
                              color: CustomColors.textColorBlack,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: "${weatherDataCurrent.current.uvIndex}",
                          style: const TextStyle(
                              fontSize: 14,
                              height: .8,
                              color: CustomColors.textColorBlack,
                              fontWeight: FontWeight.w400))
                    ])),
                  ],
                )
              ],
            ))
      ],
    );
  }
}
