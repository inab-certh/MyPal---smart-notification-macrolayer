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

  List<int> getPriorityForAppointmentWithNoTreatment() {
    List<int> priorityOfAppointment = new List();
    if (disease == 'CLL') {
      switch (clinic) {
        case 'KI':
          priorityOfAppointment.add(2);
          break;

        case 'FN BRNO':
          priorityOfAppointment.add(1);
          break;

        case 'USR':
          priorityOfAppointment.add(2);
          priorityOfAppointment.add(1);
          break;
      }
    } else if (disease == 'MDS') {
      priorityOfAppointment.add(2);
      priorityOfAppointment.add(1);
    } else {
      //TODO: check print
      print(
          'error in getPriority method of MacroScheduleHandler class at the disease if statement');
    }
    return priorityOfAppointment;
  }

  List<int> getPriorityForAppointmentWithTreatment() {
    List<int> priorityOfAppointment = new List();
    if (disease == 'CLL') {
      switch (clinic) {
        case 'KI':
          priorityOfAppointment.add(2);
          priorityOfAppointment.add(1);
          break;

        case 'FN BRNO':
          priorityOfAppointment.add(2);
          break;

        case 'USR':
          priorityOfAppointment.add(2);
          priorityOfAppointment.add(1);
          break;
      }
    } else {
      //TODO: check print
      print(
          'error in getPriority method of MacroScheduleHandler class at the disease if statement');
    }
    return priorityOfAppointment;
  }

  List<int> CalculateStartingHourOfCllPatientAppointmentWithNoTreatment() {}
}
