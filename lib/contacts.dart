import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:convert/convert.dart';
import 'package:flutter/services.dart';
import 'package:FJR/globals.dart' as globals;

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<String> firstInitials = [];
  List<String> lastNames = [];
  List<String> roles = [];
  List<String> emails = [];

  void getTeacherData() {
    setState(() {
      firstInitials = globals.firstInitials;
      lastNames = globals.lastNames;
      roles = globals.roles;
      emails = globals.emails;
    });
  }

  Future<void> _showEmailCopiedAlert(email) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Email copied to clipboard"),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[Text("$email has been copied")],
            )),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  print("Alert dismissed");
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    getTeacherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: firstInitials.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  color: Color.fromRGBO(26, 25, 27, 1),
                  child: InkWell(
                    onTap: () {
                      Clipboard.setData(new ClipboardData(text: emails[index]));
                      _showEmailCopiedAlert(emails[index]);
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${lastNames[index]}, ${firstInitials[index]}.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                roles[index],
                                style: TextStyle(color: Colors.grey[400]),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Divider(
                    color: Colors.grey,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
