import 'package:flutter/material.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Image(
          image: AssetImage("assets/Floor 1 map HD.png"),
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
