import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Bus extends StatefulWidget {
  @override
  _BusState createState() {
    return _BusState();
  }
}

class _BusState extends State {
  List<String> kipLoopTimes = [];
  List<String> timmiesTimes = [];
  List<String> lakeshoreEastTimes = [];
  List<String> lakeshoreWestTimes = [];

  List<Widget> kipLoopWidgets = [
    SpinKitFadingCircle(
      color: Colors.white,
      size: 40.0,
    )
  ];

  List<Widget> timmiesWidgets = [
    SpinKitFadingCircle(
      color: Colors.white,
      size: 40.0,
    )
  ];

  List<Widget> lakeshoreEastWidgets = [
    SpinKitFadingCircle(
      color: Colors.white,
      size: 40.0,
    )
  ];

  List<Widget> lakeshoreWestWidgets = [
    SpinKitFadingCircle(
      color: Colors.white,
      size: 40.0,
    )
  ];

  bool haveBusData = false;

  Future<void> getBusData() async {
    final kipLoop = await http.get("https://myttc.ca/kipling_loop.json");
    final timmies = await http.get(
        "https://myttc.ca/northbound_on_colonel_samuel_at_humber_college_building_m.json");
    final lakeshore = await http
        .get("https://myttc.ca/eastbound_on_lake_shore_at_kipling.json");
    //eastbound_on_lake_shore_at_kipling

    final kipLoopData = jsonDecode(kipLoop.body);
    final timmiesData = jsonDecode(timmies.body);
    final lakeshoreData = jsonDecode(lakeshore.body);
    //neville = eastbound (west side)
    //long branch = westbound (east side)

    // """
    // {
    // "time":1612797012,
    // "stops":[
    //   {
    //     "uri":"kipling_loop",
    //     "agency":"Toronto Transit Commission",
    //     "name":"Kipling Loop",
    //     "routes":[
    //       {
    //         "uri":"44_kipling_south",
    //         "stop_times":[
    //           {
    //             "service_id":1,
    //             "shape":"44 Kipling South To Kipling Station",
    //             "departure_time":"10:13a",
    //             "departure_timestamp":1612797189
    //           },
    //           {
    //             "service_id":1,
    //             "shape":"44 Kipling South To Kipling Station",
    //             "departure_time":"10:19a",
    //             "departure_timestamp":1612797549
    //           },
    //           {
    //             "service_id":1,
    //             "shape":"44 Kipling South To Kipling Station",
    //             "departure_time":"10:25a",
    //             "departure_timestamp":1612797909
    //           }
    //         ],
    //         "route_group_id":"40",
    //         "name":"44 Kipling South"
    //       }
    //     ]
    //   }
    // ],
    // "uri":"kipling_loop",
    // "name":"Kipling Loop"
    // }
    // """

    List<String> tempKipLoopTimes = [];
    List<String> tempTimmiesTimes = [];
    List<String> tempLakeshoreEastTimes = [];
    List<String> tempLakeshoreWestTimes = [];

    int currentTime = kipLoopData["time"];
    DateTime parsedCurrentTime =
        DateTime.fromMillisecondsSinceEpoch(currentTime * 1000);

    // Kipling loop times
    for (var i = 0; i < 3; i++) {
      int timeString = kipLoopData["stops"][0]["routes"][0]["stop_times"][i]
          ["departure_timestamp"];
      DateTime parsedDate =
          DateTime.fromMillisecondsSinceEpoch(timeString * 1000);
      tempKipLoopTimes
          .add(parsedDate.difference(parsedCurrentTime).inMinutes.toString());
    }

    // Timmies stop times
    for (var i = 0; i < 3; i++) {
      int timeString = timmiesData["stops"][0]["routes"][0]["stop_times"][i]
          ["departure_timestamp"];
      DateTime parsedDate =
          DateTime.fromMillisecondsSinceEpoch(timeString * 1000);
      tempTimmiesTimes
          .add(parsedDate.difference(parsedCurrentTime).inMinutes.toString());
    }

    // Lakeshore East times
    for (var i = 0; i < 3; i++) {
      int timeString = lakeshoreData["stops"][0]["routes"][1]["stop_times"][i]
          ["departure_timestamp"];
      DateTime parsedDate =
          DateTime.fromMillisecondsSinceEpoch(timeString * 1000);
      tempLakeshoreEastTimes
          .add(parsedDate.difference(parsedCurrentTime).inMinutes.toString());
    }

    // Lakeshore West times
    for (var i = 0; i < 3; i++) {
      int timeString = lakeshoreData["stops"][4]["routes"][1]["stop_times"][i]
          ["departure_timestamp"];
      DateTime parsedDate =
          DateTime.fromMillisecondsSinceEpoch(timeString * 1000);
      tempLakeshoreWestTimes
          .add(parsedDate.difference(parsedCurrentTime).inMinutes.toString());
    }

    setState(() {
      kipLoopTimes = tempKipLoopTimes;
      timmiesTimes = tempTimmiesTimes;
      lakeshoreEastTimes = tempLakeshoreEastTimes;
      lakeshoreWestTimes = tempLakeshoreWestTimes;
      kipLoopWidgets = [
        SizedBox(
          width: 50,
          height: 40,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "44",
              style: TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "${kipLoopTimes[0]}, ${kipLoopTimes[1]}, ${kipLoopTimes[2]} minutes",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        )
      ];
      timmiesWidgets = [
        SizedBox(
          width: 50,
          height: 40,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "44",
              style: TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "${timmiesTimes[0]}, ${timmiesTimes[1]}, ${timmiesTimes[2]} minutes",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        )
      ];
      lakeshoreEastWidgets = [
        SizedBox(
          width: 50,
          height: 40,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "501",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "${lakeshoreEastTimes[0]}, ${lakeshoreEastTimes[1]}, ${lakeshoreEastTimes[2]} minutes",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        )
      ];
      lakeshoreWestWidgets = [
        SizedBox(
          width: 50,
          height: 40,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "501",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "${lakeshoreWestTimes[0]}, ${lakeshoreWestTimes[1]}, ${lakeshoreWestTimes[2]} minutes",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        )
      ];
    });

    print(kipLoopTimes);
    print(timmiesTimes);
    print(lakeshoreEastTimes);
    print(lakeshoreWestTimes);

    //print(lakeshoreData["shapes"][0]["stops"][8]);
  }

  @override
  void initState() {
    getBusData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "South Stop",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image(
                              image: AssetImage("assets/Bus South Stop.jpg"))),
                    ),
                    Row(
                      children: kipLoopWidgets,
                    ),
                    Divider(
                      color: Colors.grey[700],
                      thickness: 1,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tim Hortons",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                            image: AssetImage("assets/Bus Tim Hortons.jpg")),
                      ),
                    ),
                    Row(
                      children: timmiesWidgets,
                    ),
                    Divider(
                      color: Colors.grey[700],
                      thickness: 1,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Lakeshore East",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                            image: AssetImage("assets/Bus Lakeshore East.jpg")),
                      ),
                    ),
                    Row(
                      children: lakeshoreEastWidgets,
                    ),
                    Divider(
                      color: Colors.grey[700],
                      thickness: 1,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Lakeshore West",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                            image: AssetImage("assets/Bus Lakeshore West.jpg")),
                      ),
                    ),
                    Row(
                      children: lakeshoreWestWidgets,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
