import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Controllers/GlobalControllers.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String city = "";
  String date = DateFormat.yMMMMd().format(DateTime.now());

  GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(
        globalController.latitude().value, globalController.longitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    setState(() {
      city = placemark[0].locality.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: TextStyle(fontSize: 30),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        )
      ],
    );
  }
}
