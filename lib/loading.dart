import 'package:FJR/announcements.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:FJR/globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:FJR/page_layout.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:FJR/serverkeys.dart' as serverkeys;

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void changePage() async {
    final keyApplicationId = serverkeys.applicationId;
    final keyClientKey = serverkeys.clientKey;
    final keyParseServerUrl = 'https://parseapi.back4app.com';

    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, autoSendSessionId: true);

    var apiResponse = await ParseObject("announcementsList").getAll();

    if (apiResponse.success) {
      List<String> tempMessagesList = [];
      List<DateTime> tempDateList = [];
      List<String> tempDateStringList = [];
      List<String> tempChannelList = [];
      List<Color> tempColorList = [];
      List<Color> tempAccentColorList = [];

      for (var map in apiResponse.results) {
        tempMessagesList.add(map["message"]);
        tempDateList.add(map["createdAt"]);
        tempChannelList.add(map["channel"]);
      }

      for (var date in tempDateList) {
        DateFormat dateFormatter = DateFormat("MMM d, y");
        String formattedDate = dateFormatter.format(date);
        DateFormat timeFormatter = DateFormat("jm");
        String formattedTime = timeFormatter.format(date);
        tempDateStringList.add("Posted $formattedDate at $formattedTime");
      }

      for (var i = 0; i < tempChannelList.length; i++) {
        if (tempChannelList[i] == "Send to Everyone") {
          tempChannelList[i] = "General Announcements";
        }
        switch (tempChannelList[i]) {
          case "General Announcements":
            tempColorList.add(Color.fromRGBO(84, 84, 84, 1));
            tempAccentColorList.add(Color.fromRGBO(191, 191, 191, 1));
            break;
          case "Events":
            tempColorList.add(Color.fromRGBO(123, 108, 48, 1));
            tempAccentColorList.add(Color.fromRGBO(246, 209, 81, 1));
            break;
          case "Civvies days":
            tempColorList.add(Colors.green[800]);
            tempAccentColorList.add(Colors.green[300]);
            break;
          case "PLC days":
            tempColorList.add(Color.fromRGBO(76, 52, 109, 1));
            tempAccentColorList.add(Color.fromRGBO(202, 167, 247, 1));
            break;
          case "Library":
            tempColorList.add(Color.fromRGBO(120, 77, 46, 1));
            tempAccentColorList.add(Color.fromRGBO(239, 151, 82, 1));
            break;
          case "PA days":
            tempColorList.add(Color.fromRGBO(116, 51, 47, 1));
            tempAccentColorList.add(Color.fromRGBO(237, 127, 124, 1));
            break;
          case "Sports and Clubs":
            tempColorList.add(Colors.blue[800]);
            tempAccentColorList.add(Colors.lightBlue[300]);
            break;
          default:
            tempColorList.add(Color.fromRGBO(84, 84, 84, 1));
            tempAccentColorList.add(Color.fromRGBO(191, 191, 191, 1));
            break;
        }
      }

      var reversedMessagesList =
          new List<String>.from(tempMessagesList.reversed);
      var reversedDateStringList =
          new List<String>.from(tempDateStringList.reversed);
      var reversedChannelList = new List<String>.from(tempChannelList.reversed);
      var reversedColorList = new List<Color>.from(tempColorList.reversed);
      var reversedAccentColorList =
          new List<Color>.from(tempAccentColorList.reversed);

      globals.messagesList = reversedMessagesList;
      globals.datePostedList = reversedDateStringList;
      globals.channelList = reversedChannelList;
      globals.announcementColors = reversedColorList;
      globals.accentColors = reversedAccentColorList;

      List<String> tempFirstInitials = [];
      List<String> tempLastNames = [];
      List<String> tempRoles = [];
      List<String> tempEmails = [];

      final String jsonData =
          await rootBundle.loadString("assets/teachers.json");
      final jsonDecoded = jsonDecode(jsonData);

      for (var teacher in jsonDecoded["teachers"]) {
        tempFirstInitials.add(teacher["f"][0]);
        tempLastNames.add(teacher["l"]);
        tempRoles.add(teacher["r"]);
        tempEmails.add("${teacher["e"]}@tcdsb.org");
      }

      globals.firstInitials = tempFirstInitials;
      globals.lastNames = tempLastNames;
      globals.roles = tempRoles;
      globals.emails = tempEmails;

      List<List<String>> cohortWeeks = [
        ["a", "b", "a", "b", "a"],
        ["c", "d", "c", "d", "c"],
        ["a", "b", "a", "b", "b"],
        ["c", "d", "c", "d", "d"]
      ];

      List<List<String>> cohortSundays = [
        [
          "10-11",
          "11-8",
          "12-13",
          "1-24",
          "2-7",
          "3-7",
          "4-11",
          "4-25",
          "5-23",
          "6-20"
        ],
        [
          "10-18",
          "11-22",
          "1-3",
          "1-31",
          "2-14",
          "3-21",
          "4-18",
          "5-2",
          "5-30"
        ],
        ["9-27", "10-25", "11-29", "1-10", "2-21", "3-28", "5-9", "6-6"],
        ["10-4", "11-1", "12-6", "1-17", "2-28", "4-4", "5-16", "6-13"]
      ];

      int sunday = 7;
      DateTime now = new DateTime.now();
      int tempCurrentWeekday = now.weekday;

      while (now.weekday != sunday) {
        now = now.add(new Duration(days: 1));
        print(now.weekday);
      }

      now = now.subtract(new Duration(days: 7));

      DateFormat lastSundayDateFormatter = DateFormat("EEEE, LLLL d");
      String tempLastSundayDate = lastSundayDateFormatter.format(now);

      String lastSunday = "${now.month}-${now.day}";
      print(lastSunday);

      List<String> tempCohortSchedule = [];

      if (cohortSundays[0].contains(lastSunday)) {
        tempCohortSchedule = cohortWeeks[0];
      } else if (cohortSundays[1].contains(lastSunday)) {
        tempCohortSchedule = cohortWeeks[1];
      } else if (cohortSundays[2].contains(lastSunday)) {
        tempCohortSchedule = cohortWeeks[2];
      } else if (cohortSundays[3].contains(lastSunday)) {
        tempCohortSchedule = cohortWeeks[3];
      } else {
        tempCohortSchedule = ["n", "u", "l", "l", "0"];
      }

      globals.cohortSchedule = tempCohortSchedule;
      globals.currentWeekday = tempCurrentWeekday;
      globals.lastSundayDate = tempLastSundayDate;

      //print(reversedMessagesList);
      //print(reversedDateStringList);
    }

    Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return PageLayout();
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: Curves.linear, parent: animation);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }));

    print('done');
  }

  @override
  void initState() {
    changePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 25, 27, 1),
      body: SafeArea(
        child: Container(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  height: 250,
                  width: 250,
                  image: AssetImage("assets/fjr_icon_mask.png")),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  "Father John Redmond",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              Text(
                "Created by Michael Adragna and Adrian Gri",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              )
            ],
          )),
        ),
      ),
    );
  }
}
