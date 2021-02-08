import 'package:flutter/material.dart';
import 'package:fjr_app_v2/globals.dart' as globals;

class Announcements extends StatefulWidget {
  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  List<String> messageList = [];
  List<String> datePostedList = [];
  List<String> channelList = [];
  List<Color> colorList = [];
  List<Color> accentColorList = [];

  void getGlobals() {
    messageList = globals.messagesList;
    datePostedList = globals.datePostedList;
    channelList = globals.channelList;
    colorList = globals.announcementColors;
    accentColorList = globals.accentColors;
  }

  @override
  void initState() {
    getGlobals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Card(
                          elevation: 0,
                          shadowColor: Colors.grey,
                          color: colorList[index],
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      channelList[index],
                                      style: TextStyle(
                                          color: accentColorList[index],
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      datePostedList[index],
                                      style: TextStyle(
                                        color: accentColorList[index],
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      messageList[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
