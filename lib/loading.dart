import 'package:fjr_app_v2/announcements.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:fjr_app_v2/globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:fjr_app_v2/page_layout.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void changePage() async {
    final keyApplicationId = 'oedHV8CxuXPB00COyTmY6JvY2rQcBgwKDRVNj5QP';
    final keyClientKey = 'cWw8FeAaBHmpLIEufzcWi5r1fuKUNUHaBDfpTfaE';
    final keyParseServerUrl = 'https://parseapi.back4app.com';

    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, autoSendSessionId: true);

    var apiResponse = await ParseObject("announcementsList").getAll();

    if (apiResponse.success) {
      List<String> tempMessagesList = [];
      List<DateTime> tempDateList = [];
      List<String> tempDateStringList = [];
      List<String> tempChannelList = [];

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
      }

      var reversedMessagesList =
          new List<String>.from(tempMessagesList.reversed);
      var reversedDateStringList =
          new List<String>.from(tempDateStringList.reversed);
      var reversedChannelList = new List<String>.from(tempChannelList.reversed);

      globals.messagesList = reversedMessagesList;
      globals.datePostedList = reversedDateStringList;
      globals.channelList = reversedChannelList;
      //print(reversedMessagesList);
      //print(reversedDateStringList);
    }

    Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return PageLayout();
        },
        transitionDuration: Duration(milliseconds: 700),
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text("Loading"),
        ),
      ),
    );
  }
}
