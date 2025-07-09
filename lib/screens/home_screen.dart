import 'dart:async';
import 'package:flutter/material.dart';
import 'package:study_tracker_app/util/settingsbutton.dart';
import 'package:study_tracker_app/util/settingstextfield.dart';
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
    ["English", false, 10, 90],
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
    int currentHours = subjectList[index][3] ~/ 60;
    int currentMinutes = subjectList[index][3] % 60;

    TextEditingController minutesController = TextEditingController(
      text: currentMinutes.toString(),
    );
    TextEditingController hoursController = TextEditingController(
      text: currentHours.toString(),
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Update " + subjectList[index][0])),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text("Hours : "),
                  Expanded(child: InputTextField(controller: hoursController)),
                  Text(" Minutes : "),
                  Expanded(
                    child: InputTextField(controller: minutesController),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Settingsbutton(
                    buttonString: "Save",
                    onTap: () {
                      String hoursText = hoursController.text.trim();
                      String minutesText = minutesController.text.trim();

                      int hours = int.tryParse(hoursText) ?? 0;
                      int minutes = int.tryParse(minutesText) ?? 0;

                      int total = hours * 60 + minutes;

                      setState(() {
                        subjectList[index][3] = total;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Settingsbutton(
                    buttonString: "Cancel",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
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
