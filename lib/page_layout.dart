import 'package:fjr_app_v2/announcements.dart';
import 'package:flutter/material.dart';
import 'package:fjr_app_v2/map.dart';
import 'package:fjr_app_v2/schedule.dart';
import 'package:fjr_app_v2/Bus.dart';

class PageLayout extends StatefulWidget {
  @override
  _PageLayoutState createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  final List<Widget> _widgetOptions = <Widget>[
    Announcements(),
    Map(),
    Schedule(),
    Bus()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _changeAppBar(int index) {
    switch (index) {
      case 0:
        setState(() {
          newAppBar = AppBar(
            title: Text("Announcements"),
            backgroundColor: Colors.red,
          );
        });
        break;
      case 1:
        setState(() {
          newAppBar = AppBar(
            title: Text("Map"),
            bottom: TabBar(
              tabs: [
                Tab(text: "1"),
                Tab(text: "2"),
                Tab(text: "3"),
              ],
              indicatorColor: Colors.white,
            ),
            backgroundColor: Colors.red,
          );
        });
        break;
      case 2:
        setState(() {
          newAppBar = AppBar(
            title: Text("Schedule"),
            bottom: TabBar(
              tabs: [
                Tab(text: "Normal"),
                Tab(text: "PLC"),
                Tab(text: "Mass"),
              ],
              indicatorColor: Colors.white,
            ),
            backgroundColor: Colors.red,
          );
        });
        break;
      case 3:
        setState(() {
          newAppBar =
              AppBar(title: Text("Bus Times"), backgroundColor: Colors.red);
        });
    }
  }

  AppBar newAppBar = AppBar(
    title: Text("Announcements"),
    backgroundColor: Colors.red,
  );
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: newAppBar,
        body: Container(
          color: Color.fromRGBO(26, 25, 27, 1),
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: Container(
            color: Color.fromRGBO(26, 25, 27, 1),
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image(
                          height: 80,
                          width: 80,
                          image: AssetImage("assets/fjr_white_r.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Father John Redmond",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "By Michael Adragna and Adrian Gri",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                        0,
                        0.5,
                        1
                      ],
                          colors: [
                        Colors.red[700],
                        Colors.red[400],
                        Colors.red[700]
                      ])),
                ),
                ListTile(
                  leading: Image(
                    height: 50,
                    image:
                        AssetImage("assets/drawer_announcements_tab_icon.png"),
                  ),
                  title: Text(
                    'Announcements',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(0);
                    _changeAppBar(0);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    height: 50,
                    image: AssetImage("assets/drawer_map_tab_icon.png"),
                  ),
                  title: Text(
                    'Map',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(1);
                    _changeAppBar(1);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    height: 50,
                    image: AssetImage("assets/drawer_schedule_tab_icon.png"),
                  ),
                  title: Text(
                    'Schedule',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(2);
                    _changeAppBar(2);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    height: 50,
                    image: AssetImage("assets/drawer_bus_times_tab_icon.png"),
                  ),
                  title: Text(
                    'Bus Times',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(3);
                    _changeAppBar(3);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
