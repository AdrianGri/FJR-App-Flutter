import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:fjr_app_v2/loading.dart';
import 'package:fjr_app_v2/announcements.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/announcements': (context) => Announcements(),
      },
    ));
