import 'package:flutter/material.dart';
//import 'package:macronotificationsmypal/main.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:macronotificationsmypal/macroProcesses.dart';

class MySplashCit extends StatefulWidget {
  @override
  _MySplashCitState createState() => _MySplashCitState();
}

class _MySplashCitState extends State<MySplashCit> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen(
      title: Text("Please wait while your data are processed"),
      seconds: 2,
      backgroundColor: Colors.white,
      //image: Image.asset('assets/logo.png'),
      //photoSize: 70.0,
      loaderColor: Colors.blue,
      loadingText: Text('Loading'),
      navigateAfterSeconds: MacroResults(),
    );
  }
}