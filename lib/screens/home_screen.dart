import 'dart:async';
import 'package:flutter/material.dart';
import 'package:study_tracker_app/util/track_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List subjectList = [
    //(subjectName ,  timerStart , timeSpent  ,timeGoal)
    ["Math", false, 50, 1],
    ["Science", true, 30, 60],
    ["English", false, 10, 120],
  ];
  void timerStarted(int index) {
    var startTime = DateTime.now();
    //
    int elapsedTime = subjectList[index][2];

    setState(() {
      subjectList[index][1] = !subjectList[index][1];
    });

    if (subjectList[index][1]) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (!subjectList[index][1]) {
            timer.cancel();
          }
        });
        setState(() {
          var currentTime = DateTime.now();
          subjectList[index][2] =
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour) +
              elapsedTime;
        });
      });
    }
  }

  void settingsOpened(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text("Settings"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              "Track. Study. Succeed.",
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Oswald",
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: subjectList.length,
        itemBuilder: ((context, index) {
          return TrackTile(
            subjectName: subjectList[index][0],
            onTap: () {
              timerStarted(index);
            },
            settingsTap: () {
              settingsOpened(index);
            },
            timeSpent: subjectList[index][2],
            timeGoal: subjectList[index][3],
            timerStart: subjectList[index][1],
          );
        }),
      ),
    );
  }
}
