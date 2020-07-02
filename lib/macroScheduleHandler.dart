
List getPrioritiesForNotificationSchedule(DateTime date1, bool isChecked1, String clinic, String disease, DateTime prefered) {
  bool isThereAp1 = true;
  //DateTime date1 = DateTime.parse("2020-05-15 12:00:00");
  //bool isChecked1 = false;

  bool isThereAp2 = false;
  DateTime date2 = DateTime.parse("2020-05-15 16:00:00");
  bool isChecked2 = false;

 // String disease = "CLL";
  //String clinic = "KI";

  //DateTime prefered = DateTime.parse("2020-05-15 19:00:00");

  DateTime current = new DateTime.now();


  int hour1 = date1.hour;
  int hour2 = date2.hour;
  int prefHour = prefered.hour;
  int nowHour = current.hour;
  bool doubleDuration1 = false;
  bool doubleDuration2 = false;

  int start1 = hour1;
  int endAp1=0;
  int pAp1=3;
  int pTr1=3;
  int endTr1=0;
  int pAp2=3;
  int pTr2=3;
  int durationAp1=0;
  int durationTr1=0;

  int start2 = hour2;
  int endAp2=0;
  int endTr2=0;
  int durationAp2=0;
  int durationTr2=0;

  //Clinicians requirements for Appointment 1
  if (isThereAp1 == true){
    if (disease == "CLL"){
      if (clinic == "KI"){
        start1 = hour1;
        if (isChecked1 == false){
          endAp1 = start1 + 2;
          durationAp1 = endAp1 - start1;
          pAp1=1;
        } else {
          endAp1 = start1+1;
          durationAp1 = endAp1 - start1;
          pAp1=2;
          endTr1 = start1+3;
          durationTr1 = endTr1 - start1;
          pTr1=1;
          doubleDuration1 = true;
        }
      } else if (clinic == "FN BRNO" ){
        start1 = hour1 + 1;
        if (isChecked1 == false){
          endAp1 = start1 + 1;
          durationAp1 = endAp1 - start1;
          pAp1=1;
        } else {
          endAp1 = start1 + 7;
          durationAp1 = endAp1 - start1;
          pTr1=2;
        }
      } else if (clinic == "USR"){
        start1 = hour1 + 1;
        if (isChecked1 == false){
          endAp1 = start1 + 1;
          durationAp1 = endAp1 - start1;
          pAp1=2;
          endTr1 = start1 + 1;
          durationTr1 = endTr1 - start1;
          pTr1=1;
          doubleDuration1 = true;
        } else {
          endAp1 = start1+6;
          durationAp1 = endAp1 - start1;
          pAp1=2;
          endTr1 = start1+2;
          durationTr1 = endTr1 - start1;
          pTr1=1;
          doubleDuration1 = true;
        }
      } else {
        print("error: The disease you selected is not studied in the clinic you chose");
      }

    } else if (disease == "MDS"){
      if (clinic == "PAGNI"){
        start1 = hour1;
        if (isChecked1 == false){
          endAp1 = start1 + 3;
          durationAp1 = endAp1 - start1;
          pAp1=2;
          endTr1 = start1 + 5;
          durationTr1 = endTr1 - start1;
          pTr1=1;
          doubleDuration1 = true;
        }
      } else {
        print("error: The disease you selected is not studied in the clinic you chose");
      }

    } else {
      print("error: The disease you selected is not studied in the clinic you chose");
    }
  }else {
    print("no 1st Appointment was found");
  }
  // END OF CLINICIANS REQUIREMENTS for Appoimt,emt 1

  //Clinicians requirements for Appointment 2
  if (isThereAp2 == true){
    if (disease == "CLL"){
      if (clinic == "KI"){
        start2 = hour2;
        if (isChecked2 == false){
          endAp2 = start2 + 2;
          durationAp2 = endAp2 - start2;
          pAp2=1;
        } else {
          endAp2 = start2+1;
          durationAp2 = endAp2 - start2;
          pAp2=2;
          endTr2 = start2+3;
          durationTr2 = endTr2 - start2;
          pTr2=1;
          doubleDuration2 = true;
        }
      } else if (clinic == "FN BRNO" ){
        start2 = hour2 + 1;
        if (isChecked2 == false){
          endAp2 = start2 + 1;
          durationAp2 = endAp2 - start2;
          pAp2=1;
        } else {
          endAp2 = start2 + 7;
          durationAp2 = endAp2 - start2;
          pAp2=2;
        }
      } else if (clinic == "USR"){
        start2 = hour2 + 1;
        if (isChecked2 == false){
          endAp2 = start2 + 1;
          durationAp2 = endAp2 - start2;
          pAp2=2;
          endTr2 = start2 + 1;
          durationTr2 = endTr2 - start2;
          pTr2=1;
          doubleDuration2 = true;
        } else {
          endAp2 = start2+6;
          durationAp2 = endAp2 - start2;
          pAp2=2;
          endTr2 = start2+2;
          durationTr2 = endTr2 - start2;
          pTr2=1;
          doubleDuration2 = true;
        }
      } else {
        print("error: The disease you selected is not studied in the clinic you chose");
      }

    } else if (disease == "MDS"){
      if (clinic == "PAGNI"){
        start2 = hour2;
        if (isChecked2 == false){
          endAp2 = start2 + 3;
          durationAp2 = endAp2 - start2;
          pAp2=2;
          endTr2 = start2 + 5;
          durationTr2 = endTr2 - start2;
          pTr2=1;
          doubleDuration2 = true;
        }
      } else {
        print("error: The disease you selected is not studied in the clinic you chose");
      }

    } else {
      print("error: The disease you selected is not studied in the clinic you chose");
    }
  }else{
    print("no 2nd Appointment was found");
  }
  // END OF CLINICIANS REQUIREMENTS for Appointment 2

  var priorityTable = new List(24);
  var hourTable = new List(24);
  int i;
  for (i=0; i<12; i++){
    hourTable[i]=i;
    hourTable[i+12]=i;
  }


  int j = durationAp1;
  int j2 = durationTr1;
  int start12 = start1+durationAp1;
  int k = durationAp2;
  int k2 = durationTr2;
  int start22 = start2+durationAp2;

  //TABLE POPULATION
  for (i=0; i<24; i++){
    priorityTable[i] = 3;

    if (i==23 || i==0 || i==1 || i==2 || i==3 || i==4 || i==5 || i==6 || i==7 || i==8){
      priorityTable[i] = 0;
    }
    if (i==22 || i==9){
      priorityTable[i] = 2;
    }
    if (i == prefHour){
      priorityTable[i] = 4;
    }


    if (i == start1){
      priorityTable[i] = pAp1;
      j--;
    }
    if (j < durationAp1 && j >= 0){
      priorityTable[i] = pAp1;
      j--;
    }
    if (doubleDuration1 == true){
      if (i == start12){
        priorityTable[i] = pTr1;
        j2--;
      }
      if (j2 < durationTr1 && j2 >= 0){
        priorityTable[i] = pTr1;
        j2--;
      }
    }

    if (i == start2){
      priorityTable[i] = pAp2;
      k--;
    }
    if (k < durationAp2 && k >= 0){
      priorityTable[i] = pAp2;
      k--;
    }
    if (doubleDuration2 == true){
      if (i == start22){
        priorityTable[i] = pTr2;
        k2--;
      }
      if (k2 < durationTr2 && k2 >= 0){
        priorityTable[i] = pTr2;
        k2--;
      }
    }

  }
  print("");
  print(hourTable);
  print(priorityTable);
  print("");
  print("The current hour is $nowHour:00");
  print("");
  int position =0;
  int opp = 0;
  var argpos = new List(2);
  var position3 = new List(10);
  //var opp3 = new List(10);
  int opp3count=0;
  var position2 = new List(10);
  //var opp2 = new List(10);
  int opp2count=0;
  var position1 = new List(10);
  //var opp1 = new List(10);
  int opp1count=0;
  var position0 = new List(10);
  //var opp0 = new List(10);
  int opp0count=0;
  int f;
  bool done = false;
  int prior;
  var count = new List(5);
  for (i=0; i<5; i++){
    count[i]=0;
  }
  for(prior=4; prior>=0; prior--) {
    for (f=0; f<24; f++){

      if (priorityTable[f] == prior && prior == 4){
        //print(priorityTable[f]);
        opp = priorityTable[f];
        position=f;
        print("opportune time detected at $position:00 and with priority $opp");
        count[prior]++;
        done=true;
        argpos[0] = position;
        argpos[1] = opp;
        return argpos;
      }
      if (priorityTable[f] == prior && prior == 3 && done == false){
        //print(priorityTable[f]);
        //opp3[opp3count] = priorityTable[f];
        position3[opp3count]=f;
        print("opportune time detected at $f:00 and with priority $prior");
        count[prior]++;
        opp3count++;
        //opp3.add(opp3count);
        done=true;
        argpos[0] = position3;
        argpos[1] = prior;
        return argpos;
      }
      if (priorityTable[f] == prior && prior == 2 && done == false){
        //print(priorityTable[f]);
        //opp2[opp2count] = priorityTable[f];
        position2[opp2count]=f;
        print("opportune time detected at $f:00 and with priority $prior");
        count[prior]++;
        opp2count++;
        //opp2.add(opp2count);
        done=true;
        argpos[0] = position2;
        argpos[1] = prior;
        return argpos;
      }
      if (priorityTable[f] == prior && prior == 1 && done == false){
        //print(priorityTable[f]);
        //opp1[opp1count] = priorityTable[f];
        position1[opp1count]=f;
        print("opportune time detected at $f:00 and with priority $prior");
        count[prior]++;
        opp1count++;
        //opp1.add(opp1count);
        done=true;
        argpos[0] = position1;
        argpos[1] = prior;
        return argpos;
      }
      if (priorityTable[f] == prior && prior == 0 && done == false){
        //print(priorityTable[f]);
        //opp0[opp0count] = priorityTable[f];
        position0[opp0count]=f;
        print("opportune time detected at $f:00 and with priority $prior");
        count[prior]++;
        opp0count++;
        //opp0.add(opp0count);
        done=true;
        argpos[0] = position0;
        argpos[1] = prior;
        return argpos;
      }
    }
  }
  /* print(count);
    //print(opp3);
    print(position3);
    //print(opp2);
    print(position2);
   // print(opp1);
    print(position1);
    //print(opp0);
    print(position0);
    */

  //print("opportune time detected at $position:00 and with priority $opp");
  print("");
  print("0: Dont even bother, 1: Better not Bother, 2: Maybe you could, 3: Opportune momment, 4: Prefered momment, 5: Treat as 3 for testing reasons ");
return argpos;
}