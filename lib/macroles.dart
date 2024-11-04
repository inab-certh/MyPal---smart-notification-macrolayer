import 'dart:math';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

const presentTime = "2020-07-15T15:10:00Z";

void main() async {
  String patientId = '124';
  DateTime preferredDateTime = DateTime.parse("2020-07-17T16:00:00Z");
  var activationDuration = 2;
  var token = 'clinic_token'; // replace with clinic secret token
  var currentDate = getCurrentDate(false);
  var nextToCurrentDate = getCurrentDate(true);
  var disease = 'CLL';
  var clinic = 'KI';

  final Future<List<dynamic>> futureList =
      getData(token, patientId, currentDate);
  final list = await futureList;
  final Future<List<dynamic>> future2List =
      getData(token, patientId, nextToCurrentDate);
  final list2 = await future2List;
  var boolValue;
  var bool2Value;
  if (list[1] == 'false') {
    boolValue = false;
  } else {
    boolValue = true;
  }
  if (list2[1] == 'false') {
    bool2Value = false;
  } else {
    bool2Value = true;
  }
  print(list);
  print(list2);
  var canYou;
  if (list[0] == null || list[1] == null || list.isEmpty) {
    canYou = canIIssueANotificationNow(preferredDateTime);
    print("in createAndShowNotification, jsonAppointments are null --> return appointmentsMedicationTreatment:"+canYou.toString()+' \n if false it will be issued now, if true it will be issued at preferred time');
    if (list2[0] == null || list2[1] == null || list2.isEmpty) {
      print("in createAndShowNotification, jsonAppointments for next day are null --> return");
      return;

    }
    return;
  }
  var macroInstance = new MacroScheduleHandler(
      disease: disease,
      clinic: clinic,
      preferredTime: preferredDateTime,
      appointmentStartingTime: DateTime.parse(list[0]),
      isAppointmentForTreatment: boolValue);



  print('\npriority table for current day:');
  print(macroInstance.populatePriorityTable());
  canYou = macroInstance.canIIssueANotificationNow();
  print(
      '\nYou should find a different time slot than issuing notification now: ' +
          canYou.toString());
  if (canYou == false){
    var intervalCanYou = DateTime.parse(presentTime).minute + 2;//plus 2 minutes for now
    print('The notification will be issued now at ' + DateTime.parse(presentTime).hour.toString()+':'+intervalCanYou.toString());
  } else {
    var scheduledHour = macroInstance.whenCanIIssueANotification(false);

    if (scheduledHour == 24) {
      scheduledHour = DateTime
          .parse(presentTime)
          .hour;
      print(
          '\nSince the value is: 24 this means that the algorithm must run again for the next day if the activeDuration value is 7');
      switch (activationDuration) {
        case 2:
          canYou = false;
          print(
              'else (activeDuration=2) The notification will be issued immediatly at present time which is: ' +
                  scheduledHour.toString() +
                  ':00');
          break;
        case 7:
          var macro2Instance = new MacroScheduleHandler(
              disease: disease,
              clinic: clinic,
              preferredTime: preferredDateTime,
              appointmentStartingTime: DateTime.parse(list2[0]),
              isAppointmentForTreatment: bool2Value);
          print('\npriority table for the next day:');
          print(macro2Instance.populatePriorityTable());
          var scheduled2Hour = macro2Instance.whenCanIIssueANotification(true);
          print(
              '\nTime to issue the next day is: ' + scheduled2Hour.toString() +
                  ':00');
          var interval2Time =
              scheduled2Hour + 24 - DateTime
                  .parse(presentTime)
                  .hour;
          print(
              'schedule it in ' + interval2Time.toString() + ' hours from now');
          break;
      }
    } else {
      print('\nTime to issue for current day is: ' + scheduledHour.toString() +
          ':00');
      var intervalTime = scheduledHour - DateTime
          .parse(presentTime)
          .hour;
      print('schedule it in ' + intervalTime.toString() + ' hours from now');
    }
  }
}

String getCurrentDate(bool date) {
  DateTime currentDate = DateTime.parse(presentTime); //DateTime.now();
  if (date == false) {
    String searchDate = currentDate.year.toString() +
        '-' +
        currentDate.month.toString() +
        '-' +
        currentDate.day.toString();
    print('getCurrentDate gives ' + searchDate);
    return searchDate;
  } else if (date == true) {
    int nextDay = currentDate.day + 1;
    String searchNextDate = currentDate.year.toString() +
        '-' +
        currentDate.month.toString() +
        '-' +
        nextDay.toString();
    print('getCurrentDate for next day gives ' + searchNextDate);
    return searchNextDate;
  } else {
    return null;
  }
}

Future<List<String>> getData(
    String token, String patientId, String appointmentDate1) async {
  http.Response response = await http.get(
      Uri.encodeFull(
          'https://mypal1.inab.certh.gr/mypal/data-api/adult_appointments/?patient_id=' +
              patientId +
              '&appointment_date=' +
              appointmentDate1),
      headers: {
        "Authorization": "bearer " + token,
        "Content-Type": "application/json"
      });
  if (response.statusCode != 200) {
    /*throw new Exception*/print("Can not read Appointments.");
    return [null,null];
  }
  List<dynamic> resBody = jsonDecode(response.body);
  //print(resBody);
  String appointmentDate;
  bool appTreat;
  if (resBody == null || resBody.isEmpty) {
    /*throw new Exception*/print("empty Appointments.");
  } else {
    appointmentDate = resBody[0]["appointment_date"];
    appTreat = resBody[0]["is_this_a_treatment_appointment"];
    print('datetime is ' + appointmentDate);
    print('treatment status is ' + appTreat.toString());
  }
  return [appointmentDate, appTreat.toString()];
}
bool canIIssueANotificationNow(DateTime preferredTime) {
  Map<int, int> priorities = Map();

  // from 1 to 8
  for (int i = 0; i < 9; i++) {
    priorities[i] = 1;
  }

  priorities[9] = 2; // 9

  // from 10 to 21
  for (int i = 10; i < 22; i++) {
    priorities[i] = 3;
  }

  priorities[22] = 2; // 22
  priorities[23] = 1; // 23
  priorities[preferredTime.hour] = 4; // the preferred hour should be populated in this method of the class
  //print(priorities);
  bool canYou;
  int currentHour = DateTime.parse(presentTime).hour;
  if (priorities[currentHour] > 2) {
    canYou = false;
  } else {
    canYou = true;
  }
  return canYou;
}

class MacroScheduleHandler {
  String disease;
  String clinic;
  DateTime preferredTime;
  DateTime appointmentStartingTime;
  bool isAppointmentForTreatment;

  MacroScheduleHandler(
      {this.disease,
      this.clinic,
      this.preferredTime,
      this.appointmentStartingTime,
      this.isAppointmentForTreatment});

  // int appointmentStartingHour = appointmentStartingTime.hour;

  DateTime currentTime = DateTime.parse(presentTime); // new DateTime.now();

  List<int> getPriorityForAppointment() {
    List<int> priorityOfAppointment = new List();
    if (disease == 'CLL' && isAppointmentForTreatment == false) {
      switch (clinic) {
        case 'KI':
          priorityOfAppointment.add(0);
          break;

        case 'FN BRNO':
          priorityOfAppointment.add(0);
          break;

        case 'USR':
          priorityOfAppointment.add(1);
          priorityOfAppointment.add(0);
          break;
      }
    } else if (disease == 'MDS' && isAppointmentForTreatment == false) {
      priorityOfAppointment.add(1);
      priorityOfAppointment.add(0);
    } else if (disease == 'CLL' && isAppointmentForTreatment == true) {
      switch (clinic) {
        case 'KI':
          priorityOfAppointment.add(1);
          priorityOfAppointment.add(0);
          break;

        case 'FN BRNO':
          priorityOfAppointment.add(1);
          break;

        case 'USR':
          priorityOfAppointment.add(1);
          priorityOfAppointment.add(0);
          break;
      }
    } else if (disease == 'MDS' && isAppointmentForTreatment == true) {
      print(
          'in getPrioritiesForAppointments MDS Treatment has no ill-timed moments');
    } else {
      print(
          'error in getPriority method of MacroScheduleHandler class at the disease if statement');
    }
    return priorityOfAppointment;
  }

  int getStartingHourOfAppointment() {
    int startingHour;
    if (disease == 'CLL') {
      switch (clinic) {
        case 'KI':
          startingHour = appointmentStartingTime.hour;
          break;

        case 'FN BRNO':
          startingHour = appointmentStartingTime.hour + 1;
          break;

        case 'USR':
          startingHour = appointmentStartingTime.hour + 1;
          break;
      }
    } else if (disease == 'MDS') {
      startingHour = appointmentStartingTime.hour;
    } else {
      print(
          'error in calculate starting time method of MacroScheduleHandler class at the disease if statement');
    }
    return startingHour;
  }

  List<int> getDurationOfAppointment() {
    List<int> durationOfAppointment = new List();
    if (disease == 'CLL' && isAppointmentForTreatment == false) {
      switch (clinic) {
        case 'KI':
          durationOfAppointment.add(2);
          break;

        case 'FN BRNO':
          durationOfAppointment.add(1);
          break;

        case 'USR':
          durationOfAppointment.add(1);
          durationOfAppointment.add(1);
          break;
      }
    } else if (disease == 'MDS' && isAppointmentForTreatment == false) {
      durationOfAppointment.add(3);
      durationOfAppointment.add(5);
    } else if (disease == 'CLL' && isAppointmentForTreatment == true) {
      switch (clinic) {
        case 'KI':
          durationOfAppointment.add(1);
          durationOfAppointment.add(3);
          break;

        case 'FN BRNO':
          durationOfAppointment.add(7);
          break;

        case 'USR':
          durationOfAppointment.add(6);
          durationOfAppointment.add(2);
          break;
      }
    } else if (disease == 'MDS' && isAppointmentForTreatment == true) {
      durationOfAppointment.add(0);

      print(
          'in getDurationForAppointments MDS Treatment has no ill-timed moments');
    } else {
      print(
          'error in calculate duration method of MacroScheduleHandler class at the disease if statement');
    }
    return durationOfAppointment;
  }

  bool canIIssueANotificationNow() {
    bool canYou;
    var issueNotification = populatePriorityTable();
    int currentHour = currentTime.hour;
    if (issueNotification[currentHour] > 2) {
      canYou = false;
    } else {
      canYou = true;
    }
    return canYou;
  }

  Map initializeHourTable() {
    var i;
    Map<int, int> priorities = Map();
    for (i = 0; i < 24; i++) {
      priorities[i] = 3;
    }
    for (i = 0; i < 9; i++) {
      priorities[i] = 1;
    }
    priorities[23] = 1;
    priorities[9] = 2;
    priorities[22] = 2;
    priorities[preferredTime.hour] = 4;
    return priorities;
  }

  Map populatePriorityTable() {
    Map<int, int> priorities = initializeHourTable();
    var i;
    var startingHour = getStartingHourOfAppointment();
    var durationOfAppointment = getDurationOfAppointment();
    var priorityOfAppointment = getPriorityForAppointment();
    if (durationOfAppointment.length == 2) {
      for (i = startingHour; i < startingHour + durationOfAppointment[0]; i++) {
        priorities[i] = priorityOfAppointment[0];
      }
      for (i = startingHour + durationOfAppointment[0];
          i <
              startingHour +
                  durationOfAppointment[0] +
                  durationOfAppointment[1];
          i++) {
        priorities[i] = priorityOfAppointment[1];
      }
    } else {
      for (i = startingHour; i < startingHour + durationOfAppointment[0]; i++) {
        priorities[i] = priorityOfAppointment[0];
      }
    }

    return priorities;
  }

  int whenCanIIssueANotification(bool isThisAboutNextDay) {
    int newScheduledHour;
    var i;
    var readyPriorityTable = populatePriorityTable();
    List priority4Count = new List();
    List priority3Count = new List();
    List priority2Count = new List();
    List priority1Count = new List();
    List priority0Count = new List();

    for (i = 0; i <= readyPriorityTable.length; i++) {
      switch (readyPriorityTable[i]) {
        case 4:
          priority4Count.add(i);
          break;

        case 3:
          priority3Count.add(i);
          break;

        case 2:
          priority2Count.add(i);
          break;

        case 1:
          priority1Count.add(i);
          break;

        case 0:
          priority0Count.add(i);
          break;
      }
    }
    var priority42Count;
    var priority32Count;
    var priority22Count;
    var priority12Count;
    var priority02Count;

    if (isThisAboutNextDay == false) {
      priority42Count = checkScheduledTimeWithCurrentHour(priority4Count);
      priority32Count = checkScheduledTimeWithCurrentHour(priority3Count);
      priority22Count = checkScheduledTimeWithCurrentHour(priority2Count);
      priority12Count = checkScheduledTimeWithCurrentHour(priority1Count);
      priority02Count = checkScheduledTimeWithCurrentHour(priority0Count);
    } else if (isThisAboutNextDay == true) {
      priority42Count = priority4Count;
      priority32Count = priority3Count;
      priority22Count = priority2Count;
      priority12Count = priority1Count;
      priority02Count = priority0Count;
    } else {
      print(
          'error in line 390. Cannot resolve for what day is this calculation');
    }
    if (priority42Count.isNotEmpty) {
      newScheduledHour = priority42Count[0];
    } else if (priority32Count.isNotEmpty) {
      if (priority32Count.length > 1) {
        newScheduledHour = randomFunction(priority32Count);
      } else {
        newScheduledHour = priority32Count[0];
      }
    } else if (priority22Count.isNotEmpty) {
      if (priority22Count.length > 1) {
        newScheduledHour = randomFunction(priority22Count);
      } else {
        newScheduledHour = priority22Count[0];
      }
    } else if (priority12Count.isNotEmpty) {
      if (priority12Count.length > 1) {
        newScheduledHour = randomFunction(priority12Count);
      } else {
        newScheduledHour = priority12Count[0];
      }
    } else if (priority02Count.isNotEmpty) {
      if (priority02Count.length > 1) {
        newScheduledHour = randomFunction(priority02Count);
      } else {
        newScheduledHour = priority02Count[0];
      }
    } else {
      if (newScheduledHour == null) {
        newScheduledHour = 24;
        print(
            '\nin whenCanIIssueANotification: no optimum time detected for today');
      } else {
        print(
            'error in choosing the best time method <whenCanIIssueANotification>');
      }
    }
    print('\nThe different times with priorities 4 are: $priority4Count');
    print(
        'The different times with priorities 4 when compering with current timestamp are: $priority42Count');
    print('\nThe different times with priorities 3 are: $priority3Count');
    print(
        'The different times with priorities 3 when compering with current timestamp are: $priority32Count');
    print('\nThe different times with priorities 2 are: $priority2Count');
    print(
        'The different times with priorities 2 when compering with current timestamp are: $priority22Count');
    print('\nThe different times with priorities 1 are: $priority1Count');
    print(
        'The different times with priorities 1 when compering with current timestamp are: $priority12Count');
    print('\nThe different times with priorities 0 are: $priority0Count');
    print(
        'The different times with priorities 0 when compering with current timestamp are: $priority02Count');

    return newScheduledHour;
  }

  int randomFunction(List list) {
    final _random = new Random();
    var element = list[_random.nextInt(list.length)];
    return element;
  }

  List<int> checkScheduledTimeWithCurrentHour(List list) {
    var currentHour = currentTime.hour;
    List<int> newList = new List();
    for (int i = 0; i < list.length; i++) {
      if (list[i] > currentHour) {
        newList.add(list[i]);
      }
    }
    return newList;
  }
}
