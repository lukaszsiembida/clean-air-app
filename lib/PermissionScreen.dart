import 'package:clean_air/AirScreen.dart';
import 'package:clean_air/MyHomePage.dart';
import 'package:clean_air/SplashScreen.dart';
import 'package:clean_air/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class PermissionScreen extends StatefulWidget {
  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
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
                  image: AssetImage('icons/hand-wave.png'),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(
                  "Hejka!",
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
                  'Aplikacja ${Strings.appTitle} potrzebuje do działania\nprzybliżonej lokalizacji urządzenia',
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
              margin: EdgeInsets.only(left: 10.0, right: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'Zgoda!',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                  ), onPressed: () async {
                    LocationPermission permission = await Geolocator.requestPermission();
                    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SplashScreen())
                      );
                    }
                },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
