import 'dart:async';
import 'package:flutter/material.dart';
import 'package:landmark_classifier/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => HomePage(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: double.infinity,
            child: Image.asset(
              'assets/images/splash.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 350,
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'LANDMARK\nCLASSIFIER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.deepOrange,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
