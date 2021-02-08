import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Card(
              color: Color.fromRGBO(48, 47, 49, 1),
              elevation: 0,
              child: InkWell(
                onTap: () {
                  _launchURL(
                      "https://docs.google.com/forms/d/e/1FAIpQLScItqsVKB7MyOSMKMHzh41xvNSxGpgM9HtiQ8ni84ujuCmdJg/viewform?usp=sf_link");
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 45,
                        width: 45,
                        child: Image(
                          image: AssetImage("assets/security_white.png"),
                        ),
                      ),
                    ),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
