import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Levels",
        style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w400
        ),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            Text("Level 1"),
            Text("Level 2"),
            Text("Level 3"),
            Text("Level 4"),
            Text("Level 5"),
            Text("Level 6"),
            Text("Level 7"),
            Text("Level 8"),
            Text("Level 9"),
            Text("Level 10"),
          ],
        )
      ]),
    ));
  }
}
