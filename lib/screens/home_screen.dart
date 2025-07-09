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
    ["Math", false, 5000, 1000],
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

  void deleteSubject(int index) {
    setState(() {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Delete '${subjectList[index][0]}'?"),
              content: Text("Are you sure you want to delete this subject?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      subjectList.removeAt(index);
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Delete", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
      );
    });
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
          // ignore: prefer_interpolation_to_compose_strings
          title: Center(child: Text("Update " + subjectList[index][0])),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text("Hours : "),
                  Expanded(
                    child: InputTextField(
                      controller: hoursController,
                      label: '',
                    ),
                  ),
                  Text(" Minutes : "),
                  Expanded(
                    child: InputTextField(
                      controller: minutesController,
                      label: '',
                    ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          TextEditingController nameController = TextEditingController();
          TextEditingController hoursController = TextEditingController();
          TextEditingController minutesController = TextEditingController();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Center(
                  child: Text(
                    "Add subject!",
                    style: TextStyle(fontFamily: "Oswald"),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text("Name :  "),
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Subject Name",
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Hours : "),
                        Expanded(
                          child: InputTextField(
                            controller: hoursController,
                            label: '',
                          ),
                        ),
                        Text(" Minutes : "),
                        Expanded(
                          child: InputTextField(
                            controller: minutesController,
                            label: '',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Settingsbutton(
                          buttonString: "Add",
                          onTap: () {
                            String subjectName = nameController.text.trim();
                            int hours =
                                int.tryParse(hoursController.text.trim()) ?? 0;
                            int minutes =
                                int.tryParse(minutesController.text.trim()) ??
                                0;
                            int goalTime = hours * 60 + minutes;
                            setState(() {
                              subjectList.add([
                                subjectName,
                                false,
                                0,
                                goalTime,
                              ]);
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
        },
      ),
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
            deleteTap: () {
              deleteSubject(index);
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
