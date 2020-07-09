import 'dart:math';

void main() {

  DateTime date1 = DateTime.parse("2020-07-07 11:00:00");

  DateTime date2 = DateTime.parse("2020-07-07 19:00:00");
  var macroInstanse = new MacroScheduleHandler(
      disease: 'CLL',
      clinic: 'FN BRNO',
      preferredTime: date2,
      appointmentStartingTime: date1,
      isAppointmentForTreatment: true);




  print(macroInstanse.populatePriorityTable());
  print(macroInstanse.canIIssueANotificationNow());
  print(macroInstanse.whenCanIIssueANotification());

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

  DateTime currentTime = new DateTime.now();

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
      print('MDS Treatment has no ill-timed moments');
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

      print('MDS Treatment has no ill-timed moments');
    } else {
      print(
          'error in calculate duration method of MacroScheduleHandler class at the disease if statement');
    }
    return durationOfAppointment;
  }

  bool canIIssueANotificationNow() {
    bool canYou;
    int endingHour;

    int currentHour = currentTime.hour;
    var durationOfAppointment = getDurationOfAppointment();
    int startingHour = getStartingHourOfAppointment();
    if (durationOfAppointment.length == 2) {
      endingHour =
          startingHour + durationOfAppointment[0] + durationOfAppointment[1];
    } else {
      endingHour = startingHour + durationOfAppointment[0];
    }
    if (currentHour >= startingHour && currentHour <= endingHour) {
      canYou = true;
    } else {
      canYou = false;
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
    //priorities[24] = currentTime.hour;

    return priorities;
  }

  Map populatePriorityTable() {
    Map<int, int> priorities = initializeHourTable();
    priorities[preferredTime.hour] = 4;
    var i;
    var startingHour = getStartingHourOfAppointment();
    var durationOfAppointment = getDurationOfAppointment();
    var priorityOfAppointment = getPriorityForAppointment();
    if (durationOfAppointment.length == 2) {
      for (i = startingHour; i < startingHour + durationOfAppointment[0]; i++) {
        priorities[i] = priorityOfAppointment[0];
      }
      for (i = startingHour + durationOfAppointment[0]; i < startingHour + durationOfAppointment[0] + durationOfAppointment[1]; i++) {
        priorities[i] = priorityOfAppointment[1];
      }
    } else {
      for (i = startingHour; i < startingHour + durationOfAppointment[0]; i++) {
        priorities[i] = priorityOfAppointment[0];
      }
    }

    return priorities;
  }

  int whenCanIIssueANotification() {
    int newScheduledHour;
    var i;
    var readyPriorityTable = populatePriorityTable();
    List priority4Count = new List();
    List priority3Count= new List();
    List priority2Count= new List();
    List priority1Count= new List();
    List priority0Count= new List();

    //print(readyPriorityTable.containsValue(4));
    //readyPriorityTable.forEach((key, ) => {  });

    for (i = 0; i <= readyPriorityTable.length; i++) {
      switch (readyPriorityTable[i]) {
        case 4:
          priority4Count.add(i);
          //print(priority4Count);
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

    if (priority4Count.isNotEmpty) {

      newScheduledHour = priority4Count[0];

    } else if (priority3Count.isNotEmpty) {
      if (priority3Count.length > 1) {

        newScheduledHour = randomFunction(priority3Count);
      } else {
        newScheduledHour = priority3Count[0];
      }
    } else if (priority2Count.isNotEmpty) {
      if (priority2Count.length > 1) {
        print(priority2Count);
        newScheduledHour = randomFunction(priority2Count);
      } else {
        newScheduledHour = priority2Count[0];
      }
    } else if (priority1Count.isNotEmpty) {
      if (priority1Count.length > 1) {
        newScheduledHour = randomFunction(priority1Count);
      } else {
        newScheduledHour = priority1Count[0];
      }
    } else if (priority0Count.isNotEmpty) {
      if (priority0Count.length > 1) {
        newScheduledHour = randomFunction(priority0Count);
      } else {
        newScheduledHour = priority0Count[0];
      }
    } else {
      print('error');
    }
    print(priority4Count);
    print(priority3Count);
    print(priority2Count);
    print(priority1Count);
    print(priority0Count);
    return newScheduledHour;
  }

  int randomFunction(List list) {
    final _random = new Random();

// generate a random index based on the list length
// and use it to retrieve the element
    var element = list[_random.nextInt(list.length)];
    return element;
    // print("$r is in the range of $min and $max");
  }
}
