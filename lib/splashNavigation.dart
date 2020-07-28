import 'package:flutter/material.dart';
//import 'package:macronotificationsmypal/main.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:macronotificationsmypal/macroProcesses.dart';


class MySplashCit extends StatefulWidget {
  MySplashCit({Key key, this.op1, this.op2}) : super(key: key);
  final int op1;
  final int op2;

  @override
  _MySplashCitState createState() => _MySplashCitState();
}

class _MySplashCitState extends State<MySplashCit> {
  //var _position;

  var _opp;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen(
      title: Text("Please wait while your data are processed"),
      seconds: 1,
      backgroundColor: Colors.white,
      //image: Image.asset('assets/logo.png'),
      //photoSize: 70.0,
      loaderColor: Colors.blue,
      loadingText: Text('Loading'),
      navigateAfterSeconds: MacroResults(op1:_opp),
    );
  }
}