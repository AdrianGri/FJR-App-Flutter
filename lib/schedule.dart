import 'package:flutter/material.dart';
import 'package:FJR/globals.dart' as globals;

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  List<Color> scheduleColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow[600],
    Colors.green,
    Colors.lightBlue,
    Colors.purple
  ];
  List<Color> scheduleAccentColors = [
    Colors.red[300],
    Colors.orange[300],
    Colors.yellow[300],
    Colors.green[300],
    Colors.lightBlue[300],
    Colors.purple[300]
  ];
  List<String> periodName = ["1", "2", "3a", "3b", "3c", "4"];
  List<List<String>> periodTime = [
    [
      "8:30am - 9:52am",
      "9:52am - 11:12am",
      "11:12am - 11:56am",
      "11:56am - 12:36pm",
      "12:36pm - 1:16pm",
      "1:16pm - 2:36pm"
    ],
    [
      "9:55am - 10:50am",
      "10:50am - 11:45am",
      "11:45am - 12:25pm",
      "12:25pm - 1:05pm",
      "1:05pm - 1:45pm",
      "1:45pm - 2:36pm"
    ],
    [
      "8:30am - 11:00am",
      "11:00am - 11:45am",
      "11:45am - 12:25pm",
      "12:25pm - 1:05pm",
      "1:05pm - 1:50pm",
      "1:50pm - 2:36pm"
    ]
  ];

  int currentWeekday = 7;
  String lastSundayDate = "error";
  List<String> cohortSchedule = [];
  List<String> weekDays = ["MON", "TUE", "WED", "THU", "FRI"];

  List<Widget> cohortWidgets = [
    Text("error"),
    Text("error"),
    Text("error"),
    Text("error"),
    Text("error"),
  ];

  void createCohortSchedule() {
    List<Widget> tempCohortWidgets = [];
    for (var i = 0; i < 5; i++) {
      if (i == currentWeekday - 1) {
        tempCohortWidgets.add(Container(
          child: Column(
            children: <Widget>[
              Text(
                weekDays[i].toUpperCase(),
                style: TextStyle(
                    color: Colors.red[400], fontWeight: FontWeight.w500),
              ),
              Text(
                cohortSchedule[i].toUpperCase(),
                style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
      } else {
        tempCohortWidgets.add(Container(
          child: Column(
            children: <Widget>[
              Text(
                weekDays[i].toUpperCase(),
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              Text(
                cohortSchedule[i].toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
      }
    }

    setState(() {
      cohortWidgets = tempCohortWidgets;
    });
  }

  @override
  void initState() {
    cohortSchedule = globals.cohortSchedule;
    currentWeekday = globals.currentWeekday;
    lastSundayDate = globals.lastSundayDate;
    createCohortSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListView scheduleListView(scheduleIndex) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Card(
              elevation: 0,
              shadowColor: Colors.grey,
              color: scheduleColors[index],
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      color: scheduleAccentColors[index],
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(5),
                        bottomLeft: const Radius.circular(5),
                      ),
                    ),
                    //color: Colors.red[300],
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Text(
                          periodName[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: Text(
                      periodTime[scheduleIndex][index],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Week beginning on $lastSundayDate:",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: cohortWidgets,
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  scheduleListView(0),
                  scheduleListView(1),
                  scheduleListView(2)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
