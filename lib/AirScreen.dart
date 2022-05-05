import 'package:clean_air/MyHomePage.dart';
import 'package:clean_air/PermissionScreen.dart';
import 'package:clean_air/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'main.dart';

class AirScreen extends StatefulWidget {
  final AirQuality air;

  AirScreen({required this.air});

  @override
  State<AirScreen> createState() => _AirScreenState();
}

class _AirScreenState extends State<AirScreen> {

  PanelController _pc = new PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: new Color(0xffffffff),
              gradient: getGradientByMood(widget.air),
            ),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Jakość powietrza",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 14.0,
                            height: 1.2,
                            color: getBackgroudTextColor(widget.air),
                            fontWeight: FontWeight.w300)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 2)),
                  Text(
                    widget.air.quality,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 22.0,
                            height: 1.2,
                            color: getBackgroudTextColor(widget.air),
                            fontWeight: FontWeight.w700)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 24)),
                  CircleAvatar(
                    radius: 91.0,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (widget.air.aqi / 200 * 100).floor().toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 64.0,
                                      height: 1.2,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "CAQI ⓘ",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _pc.open();
                                  },
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 16.0,
                                        height: 1.2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 28)),
                  IntrinsicHeight(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "PM 2,5",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                fontSize: 14.0,
                                height: 1.2,
                                color: getBackgroudTextColor(widget.air),
                                fontWeight: FontWeight.w300,
                              )),
                            ),
                            Padding(padding: EdgeInsets.only(top: 2.0)),
                            Text(
                              widget.air.pm25.toString() + "%",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                fontSize: 22.0,
                                height: 1.2,
                                color: getBackgroudTextColor(widget.air),
                                fontWeight: FontWeight.w700,
                              )),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        width: 24,
                        thickness: 1,
                        color: getBackgroudTextColor(widget.air),
                      ),
                      Container(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "PM 10",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                fontSize: 14.0,
                                height: 1.2,
                                color: getBackgroudTextColor(widget.air),
                                fontWeight: FontWeight.w300,
                              )),
                            ),
                            Padding(padding: EdgeInsets.only(top: 2.0)),
                            Text(
                              widget.air.pm10.toString() + "%",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                fontSize: 22.0,
                                height: 1.2,
                                color: getBackgroudTextColor(widget.air),
                                fontWeight: FontWeight.w700,
                              )),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    "Stacja pomiarowa",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 12.0,
                            height: 1.2,
                            color: getBackgroudTextColor(widget.air),
                            fontWeight: FontWeight.w300)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Text(
                    widget.air.station,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 14.0,
                            height: 1.2,
                            color: getBackgroudTextColor(widget.air),
                            fontWeight: FontWeight.w400)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 76)),
                ]),
          ),
          Positioned(
              left: 8,
              bottom: (76.0) * 2,
              right: 0,
              top: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: [
                    ClipRect(
                      child: Align(
                        alignment: Alignment.topLeft,
                        heightFactor: 1,
                        child: getDangerValueBottom(widget.air),
                      ),
                    ),
                    ClipRect(
                      child: Align(
                          alignment: Alignment.topLeft,
                          heightFactor: 1 - widget.air.aqi / 200.floor(),
                          child: getDangerValueTop(widget.air)),
                    ),
                  ],
                ),
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 14, left: 10, right: 10, top: 62),
                    child: Divider(
                      height: 10,
                      color: getBackgroudTextColor(widget.air),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          height: 38,
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  alignment: Alignment.centerLeft,
                                  image: getAdviceImage(widget.air),
                                ),
                                Padding(padding: EdgeInsets.only(left: 8)),
                                Text(
                                  widget.air.advice,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                    fontSize: 12.0,
                                    height: 1.2,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  )),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SlidingUpPanel(
            minHeight: 0,
            maxHeight: 340,
            controller: _pc,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            panel: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 32)),
                      Text(
                        "Indeks CAQI",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          fontSize: 14.0,
                          height: 1.2,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        )),
                      ),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        "Indeks CAQI (ang. Common Air Quality Index) pozwala przedstawić sytuację w Europiie w porównywalny i łatwy do zrozumienia sposób. Wartość indeksu jest prezentowana w postaci jednej liczby. Skala ma rozpietość od 0 do wartości powyżej 100 i powyżej bardzo zanieczyszone. Im wyższa wartość wskażnika, tym większe ryzyko złego wpływu na zdrowie i sampoczucie.",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          fontSize: 12.0,
                          height: 1.2,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        )),
                      ),
                      Padding(padding: EdgeInsets.only(top: 14)),
                      Text(
                        "Pył zawieszony PM2,5 i PM10",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          fontSize: 14.0,
                          height: 1.2,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        )),
                      ),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        "Pyły zawieszone to mieszanina bardzo małych cząstek. PM10 to wszystkie pyły mniejsze niz 10μm, natomiast w przypadku  PM2,5 nie większe niż 2,5μm. Zanieczyszczenia pyłowe mają zdolność do adsorpcji swojej powierzchni innych, bardzo szkodliwych związków chemicznych: dioksyn, furanów, metali ciężkich, czy benzo(a)pirenu - najbardziej toksycznego skłądnika smogu.",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          fontSize: 12.0,
                          height: 1.2,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        )),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    right: -10,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 16,
                          )
                        ), onPressed: () {
                          _pc.close();
                      }, child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 30,
                      ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  bool havePermission() {
    return true;
  }

  LinearGradient getGradientByMood(AirQuality air) {
    if (air.isGood) {
      return LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            new Color(0xff4acf8c),
            new Color(0xff75eda6),
          ]);
    } else if (air.isBad) {
      return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [new Color(0xfffbda61), new Color(0xfff76b1c)]);
    } else {
      return LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [new Color(0xffff4003A), new Color(0xffff8888)]);
    }
  }

  Color getBackgroudTextColor(AirQuality air) {
    if (air.isGood || air.isBad) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Image getDangerValueBottom(AirQuality air) {
    if (air.isGood || air.isBad) {
      return Image.asset('icons/danger-value-negative.png', scale: 0.9);
    } else {
      return Image.asset('icons/danger-value.png', scale: 0.9);
    }
  }

  getDangerValueTop(AirQuality air) {
    if (air.isGood) {
      return Image.asset('icons/danger-value-negative.png',
          scale: 0.9, color: Color(0xff4acf8c));
    } else if (air.isBad) {
      return Image.asset('icons/danger-value-negative.png',
          scale: 0.9, color: Color(0xfffbda61));
    } else {
      return Image.asset('icons/danger-value.png',
          scale: 0.9, color: Color(0xffff4003A));
    }
  }

  getAdviceImage(AirQuality air) {
    if (air.isGood) {
      return AssetImage('icons/happy.png');
    } else if (air.isBad) {
      return AssetImage('icons/ok.png');
    } else {
      return AssetImage('icons/sad.png');
    }
  }
}
