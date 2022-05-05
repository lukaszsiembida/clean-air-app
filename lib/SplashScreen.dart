import 'dart:convert';
import 'dart:developer';

import 'package:clean_air/MyHomePage.dart';
import 'package:clean_air/PermissionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: new Color(0xffffffff),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [new Color(0xff6671e5), new Color(0xff4852d9)]),
            ),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('icons/cloud-sun.png'),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(
                  Strings.appTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 42.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text(
                  'Aplikacja do monitorowana \n czystości powietrza',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 0,
              bottom: 35,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Przywiewam dane...",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PermissionScreen()));
    } else {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        executeOnceAfterBuild();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  void executeOnceAfterBuild() async {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.lowest,
      forceAndroidLocationManager: true,
      timeLimit: Duration(seconds: 5),
    ).then((value) => loadLocationData(value)).onError((error, stackTrace) => {
          Geolocator.getLastKnownPosition(forceAndroidLocationManager: true)
              .then((value) => loadLocationData(value!),
          )});
  }

  loadLocationData(Position value) async {
    var lat = value.latitude;
    var lon = value.longitude;
    log(lat.toString() + "x" + lon.toString());
    WeatherFactory wf = new WeatherFactory("3ab31cbbafbae622aa603a1d5413c399",
        language: Language.POLISH);
    Weather w = await wf.currentWeatherByLocation(lat, lon);
    log(w.toJson().toString());
    String _endpoint = 'https://api.waqi.info/feed/';
    var keyword = 'geo:$lat;$lon';
    var key = 'c0b2370a681b6feba7894235333c4a74b7d24eb8';
    String url = '$_endpoint$keyword/?token=$key';
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> jsonBody = json.decode(response.body);
    AirQuality aq = new AirQuality(jsonBody);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(weather: w, air: aq)));
  }
}

class AirQuality {
  bool isGood = false;
  bool isBad = false;
  String quality = "";
  String advice = "";
  int aqi = 0;
  int pm25 = 0;
  int pm10 = 0;
  String station = "";

  AirQuality(Map<String, dynamic> jsonBody) {
    aqi = int.tryParse(jsonBody['data']['aqi'].toString()) ?? -1;
    pm25 = int.tryParse(jsonBody['data']['iaqi']['pm25']['v'].toString()) ?? -1;
    pm10 = int.tryParse(jsonBody['data']['iaqi']['pm10']['v'].toString()) ?? -1;
    station = jsonBody['data']['city']['name'].toString();
    setUpLevel(aqi);
  }

  void setUpLevel(int aqi) {
    if (aqi <= 100) {
      isGood = true;
      quality = "Bardzo dobra";
      advice = "Skorzystaj z dobrego powietrza";
    } else if (aqi <= 150) {
      isBad = true;
      quality = "Nie za dobra";
      advice = "Unikaj wychodzenia";
    } else {
      quality = "Bardzo zła!";
      advice = "Zostań w domu!";
    }
  }
}
