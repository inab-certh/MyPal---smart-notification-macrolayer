import 'package:flutter/material.dart';
import 'main.dart';
import 'package:splashscreen/splashscreen.dart';
import 'splashNavigation.dart';

class MacroResults extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  //final String title;
  @override
  _MacroResults createState() => new _MacroResults();
}

class _MacroResults extends State<MacroResults> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Macro Results'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Here will be displayed the info',
            ),
            /*new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),*/
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        tooltip: 'Schedule again',
        foregroundColor: Colors.white,
        icon: Icon(Icons.arrow_back),
        label: Text('Schedule new'),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyApp()));
        },

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}