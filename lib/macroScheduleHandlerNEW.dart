//import 'package:flutter/material.dart';

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

    } else if(disease == 'CLL' && isAppointmentForTreatment == true) {
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
    }else if (disease == 'MDS' && isAppointmentForTreatment == true){
//TODO: check print
      print(
          'MDS Treatment has no ill-timed moments');
    } else {
      //TODO: check print
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
      //TODO: check print
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

    } else if(disease == 'CLL' && isAppointmentForTreatment == true) {
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
    }else if (disease == 'MDS' && isAppointmentForTreatment == true){
      durationOfAppointment.add(0);
//TODO: check print
      print(
          'MDS Treatment has no ill-timed moments');
    } else {
      //TODO: check print
      print(
          'error in calculate duration method of MacroScheduleHandler class at the disease if statement');
    }
    return durationOfAppointment;
  }

  bool canIIssueANotificationNow () {
    bool canYou;
    int endingHour;
    int currentHour = currentTime.hour;
    var durationOfAppointment = getDurationOfAppointment();
    int startingHour = getStartingHourOfAppointment();
    if (durationOfAppointment.length == 2) {
      endingHour = startingHour + durationOfAppointment[0] + durationOfAppointment[1];
    } else {
      endingHour = startingHour + durationOfAppointment[0];
    }
    //bool canYou = (currentHour >= startingHour && currentHour <= endingHour) ? true : false;
    if (currentHour >= startingHour && currentHour <= endingHour){
      canYou = true;
    } else {
      canYou = false;
    }
    return canYou;
  }

  Map initializeHourTable () {
    var i;
    Map<int, int> priorities = Map();
    for (i=0; i<24; i++){
      priorities[i] = 3;
    }
    for (i=0; i<9; i++){
      priorities[i] = 1;
    }
    priorities[23] = 1;
    priorities[9] = 2;
    priorities[22] = 2;
    priorities[24] = currentTime.hour;

    return priorities;
  }

  Map populatePriorityTable () {
    Map<int, int> priorities = initializeHourTable();
    priorities[preferredTime.hour] = 4;
    var i;
    var startingHour = getStartingHourOfAppointment();
    var durationOfAppointment = getDurationOfAppointment();
    var priorityOfAppointment = getPriorityForAppointment();
    if (durationOfAppointment.length == 2) {
      for (i=startingHour; i<startingHour+durationOfAppointment[0]; i++) {
        priorities[i] = priorityOfAppointment[0];
      }
      for (i=startingHour+durationOfAppointment[0]; i<startingHour+durationOfAppointment[0]+durationOfAppointment[1] ; i++) {
        priorities[i] = priorityOfAppointment[1];
      }
    } else {
      for (i=startingHour; i<=startingHour+durationOfAppointment[0]; i++) {
        priorities[i] = priorityOfAppointment[0];}
    }

    return priorities;
  }

  DateTime whenCanIIssueANotification () {
    DateTime newScheduledDateTime;

    return newScheduledDateTime;
  }

}
