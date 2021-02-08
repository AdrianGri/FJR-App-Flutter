import 'package:FJR/announcements.dart';
import 'package:flutter/material.dart';
import 'package:FJR/map.dart';
import 'package:FJR/schedule.dart';
import 'package:FJR/Bus.dart';
import 'package:FJR/contacts.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:FJR/settings.dart';

class PageLayout extends StatefulWidget {
  @override
  _PageLayoutState createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  final List<Widget> _widgetOptions = <Widget>[
    Announcements(),
    Map(),
    Schedule(),
    Bus(),
    Contacts(),
    Announcements(), // these 4 are just filler. since those are links these
    Announcements(), // should never be called its just in case something
    Announcements(), // happens at least it goes to something instead of
    Announcements(), // crashing
    Settings(),
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
        break;
      case 4:
        setState(() {
          newAppBar =
              AppBar(title: Text("Contact"), backgroundColor: Colors.red);
        });
        break;
      case 9:
        setState(() {
          newAppBar =
              AppBar(title: Text("Settings"), backgroundColor: Colors.red);
        });
        break;
    }
  }

  AppBar newAppBar = AppBar(
    title: Text("Announcements"),
    backgroundColor: Colors.red,
  );
  int _selectedIndex = 0;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
                ListTile(
                  leading: Image(
                    height: 50,
                    image: AssetImage("assets/drawer_contact_tab_icon.png"),
                  ),
                  title: Text(
                    'Contact',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(4);
                    _changeAppBar(4);
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    height: 50,
                    image: AssetImage(
                        "assets/drawer_anonymous_alerts_tab_icon.png"),
                  ),
                  title: Text(
                    'Anonymous Alerts',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _launchURL(
                        "https://www.anonymousalerts.com/tcdsb/Mobile/default.aspx");
                  },
                ),
                ListTile(
                  leading: Image(
                    height: 50,
                    image: AssetImage("assets/drawer_website_tab_icon.png"),
                  ),
                  title: Text(
                    'Website',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _launchURL(
                        "https://www.tcdsb.org/schools/FATHERJOHNREDMOND/Pages/default.aspx");
                  },
                ),
                ListTile(
                  leading: Image(
                    height: 50,
                    image: AssetImage("assets/drawer_twitter_tab_icon.png"),
                  ),
                  title: Text(
                    'Twitter',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _launchURL("https://mobile.twitter.com/FJRCSS");
                  },
                ),
                ListTile(
                  leading: Image(
                    height: 50,
                    image: AssetImage("assets/drawer_instagram_tab_icon.png"),
                  ),
                  title: Text(
                    'Instagram',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    _launchURL(
                        "https://instagram.com/fjrstudentcouncil?igshid=gwmgsv7xurwd");
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 50,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Update the state of the app
                    _onItemTapped(9);
                    _changeAppBar(9);
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
