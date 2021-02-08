import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bus extends StatefulWidget {
  @override
  _BusState createState() {
    return _BusState();
  }
}

class _BusState extends State {
  @override



  Future getBusData() async {
    final kipLoop = await http.get("https://myttc.ca/kipling_loop.json");
    final timmies = await http.get("https://myttc.ca/northbound_on_colonel_samuel_at_humber_college_building_m.json");
    final lakeshore = await http.get("https://myttc.ca/eastbound_on_lake_shore_at_kipling.json");
    //eastbound_on_lake_shore_at_kipling

    final kipLoopData = jsonDecode(kipLoop.body);
    final timmiesData = jsonDecode(timmies.body);
    final lakeshoreData = jsonDecode(lakeshore.body);
    //neville = eastbound (west side)
    //long branch = westbound (east side)

    //print(kipLoopData);
    //print(timmiesData);

    //print(lakeshoreData["shapes"][0]["stops"][8]);

    return null;
  }


  Widget build(BuildContext context) {
    getBusData();
    return (
      Scaffold()
    );
  }
}
