import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    ListView scheduleListView(schedule_index) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Card(
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
                    periodTime[schedule_index][index],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return TabBarView(
      children: [scheduleListView(0), scheduleListView(1), scheduleListView(2)],
    );
  }
}
