import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Column(
          children: <Widget>[
            Card(
              elevation: 0,
              shadowColor: Colors.grey,
              color: Colors.red,
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.red[300],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Text(
                        "1",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: Text(
                      "8:30am - 9:52am",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Image(
          image: AssetImage("assets/Floor 2 map HD.png"),
        ),
        Image(
          image: AssetImage("assets/Floor 3 map HD.png"),
        ),
      ],
    );
  }
}
