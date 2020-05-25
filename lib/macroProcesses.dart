import 'package:flutter/material.dart';
import 'main.dart';
//import 'package:splashscreen/splashscreen.dart';
//import 'splashNavigation.dart';



class MacroResults extends StatelessWidget {
  MacroResults({Key key, this.op1, this.op2}) : super(key: key);
  final int op1;
  final int op2;

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
              'opportune time detected at $op1:00 and with priority $op2',
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