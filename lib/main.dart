import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:macronotificationsmypal/macroProcesses.dart';
import 'package:macronotificationsmypal/macroScheduleHandlerNEW.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'splashNavigation.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // NOTE: if you want to find out if the app was launched via notification then you could use the following call and then do something like
  // change the default route of the app
  // var notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  runApp(MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Macro Notification Testing',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'Macro Notification Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _clinics = <String>[
    '',
    'KI',
    'FN BRNO',
    'USR',
    'Papanikolaou',
    'PAGNI'
  ];
  String _clinic = '';
  List<String> _diseases = <String>[
    '',
    'CLL',
    'MDS',
  ];
  String _disease = '';
  DateTime date1;
  bool isChecked1 = false;
  DateTime date2;
  bool isChecked2 = false;
  //DateTime date3;
  //bool isChecked3 = false;
  DateTime prefered;
  DateTime current = new DateTime.now();
  int curhour = DateTime.now().hour;
  int curminute = DateTime.now().minute;
  var argpos;



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new DateTimePickerFormField(
                    inputType: InputType.both,
                    format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                    editable: false,
                    decoration: InputDecoration(
                        labelText: 'Appointment 1',
                        hasFloatingPlaceholder: true),
                    onChanged: (dt) {
                      setState(() => date1 = dt);
                      print('Selected date: $date1');
                    },
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Text("Is this a Treatment Appointment?"),
                    ),
                    new Checkbox(
                      value: isChecked1,
                      onChanged: (value) {
                        setState(() {
                          isChecked1 = value;
                        });
                      },
                    ),
                  ]),
                  new DateTimePickerFormField(
                    inputType: InputType.both,
                    format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                    editable: false,
                    decoration: InputDecoration(
                        labelText: 'Appointment 2',
                        hasFloatingPlaceholder: true),
                    onChanged: (dt) {
                      setState(() => date2 = dt);
                      print('Selected date: $date2');
                    },
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Text("Is this a Treatment Appointment?"),
                    ),
                    new Checkbox(
                      value: isChecked2,
                      onChanged: (value) {
                        setState(() {
                          isChecked2 = value;
                        });
                      },
                    ),
                  ]),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.local_hospital),
                          labelText: 'Clinical site',
                        ),
                        isEmpty: _clinic == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _clinic,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                //  newContact.favoriteColor = newValue;
                                _clinic = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _clinics.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.bug_report),
                          labelText: 'Disease type',
                        ),
                        isEmpty: _disease == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _disease,
                            isDense: true,
                            onChanged: (String newValue2) {
                              setState(() {
                                //  newContact.favoriteColor = newValue;
                                _disease = newValue2;
                                state.didChange(newValue2);
                              });
                            },
                            items: _diseases.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new DateTimePickerFormField(
                    inputType: InputType.time,
                    format: DateFormat("HH:mm"),
                    initialTime: TimeOfDay(hour: 5, minute: 5),
                    editable: false,
                    decoration: InputDecoration(
                        labelText: 'Patients preffered time',
                        hasFloatingPlaceholder: true),
                    onChanged: (dt) {
                      setState(() => prefered = dt);
                      print('Selected date: $prefered');
                      print('Hour: $prefered.hour');
                      print('Minute: $prefered.minute');
                    },
                  ),
                  new DateTimePickerFormField(
                    inputType: InputType.time,
                    format: DateFormat("HH:mm"),
                    initialTime: TimeOfDay(hour: curhour, minute: curminute),
                    editable: false,
                    decoration: InputDecoration(
                        labelText: 'Current Timestamp',
                        hasFloatingPlaceholder: true),
                    onChanged: (dt) {
                      setState(() => current = dt);
                      print('Selected date: $current');
                      print('Hour: $current.hour');
                      print('Minute: $current.minute');
                    },
                  ),
                  new Container(
                      padding: const EdgeInsets.all(20),
                      child: new RaisedButton(
                        child:
                            const Text('Schedule Macro (Activation of ePRO)'),
                        onPressed:
                            () async{
                          argpos =await getDateTime(_disease, _clinic, prefered);
                          print(argpos);
                          await _scheduleNotification(argpos);

                          /*showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                Future.delayed(const Duration(seconds: 2));
                                return Center(child: CircularProgressIndicator(),);
                              });

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MacroResults(op1: argpos)));
*/
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MacroResults(op1: argpos[0],op2: argpos[1],)));*/
                        },
                      )),
                ],
              ))),
    );
  }
  Future<void> _scheduleNotification(int pos) async {
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(seconds: pos));


    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        icon: 'secondary_icon',
        sound: 'slow_spring_board',
        largeIcon: 'sample_large_icon',
        largeIconBitmapSource: BitmapSource.Drawable,

        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        2,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}
