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
    ["Math", false, 30, 60],
    ["Science", true, 30, 60],
    ["English", false, 10, 120],
  ];
  void timerStarted(int index) {
    setState(() {
      subjectList[index][1] = !subjectList[index][1];
    });
  }

  void settingsOpened(int index) {}

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
