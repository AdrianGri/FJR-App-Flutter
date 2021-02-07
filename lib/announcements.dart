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

  void getGlobals() {
    messageList = globals.messagesList;
    datePostedList = globals.datePostedList;
    channelList = globals.channelList;
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
                          color: Colors.blue,
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
                                        color: Colors.grey[300],
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      datePostedList[index],
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 17,
                                      ),
                                    ),
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
