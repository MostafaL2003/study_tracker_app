import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_tracker_app/models/subject_model.dart';
import 'package:study_tracker_app/util/settingsbutton.dart';
import 'package:study_tracker_app/util/settingstextfield.dart';
import 'package:study_tracker_app/util/track_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Map<DateTime, int> dailyStudyTime = {};

class _HomeScreenState extends State<HomeScreen> {
  List subjectList = [];

  late Box<Subject> subjectBox;

  @override
  void initState() {
    super.initState();
    subjectBox = Hive.box<Subject>('subjectsBox');
    loadSubjectsFromHive();
  }

  void loadSubjectsFromHive() {
    final subjects = subjectBox.values.toList();
    setState(() {
      subjectList =
          subjects
              .map((s) => [s.name, s.timerStart, s.timeSpent, s.timeGoal])
              .toList();
    });
  }

  void saveSubjectsToHive() async {
    await subjectBox.clear(); // overwrite old data

    for (var s in subjectList) {
      await subjectBox.add(
        Subject(name: s[0], timerStart: s[1], timeSpent: s[2], timeGoal: s[3]),
      );
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("✅ Subjects saved locally!")));
  }

  void timerStarted(int index) {
    var startTime = DateTime.now();
    int elapsedTime = subjectList[index][2];

    setState(() {
      subjectList[index][1] = !subjectList[index][1];
    });

    if (subjectList[index][1]) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (!subjectList[index][1]) {
          timer.cancel();
        }

        DateTime now = DateTime.now();
        DateTime today = DateTime(now.year, now.month, now.day);
        dailyStudyTime.update(today, (value) => value + 1, ifAbsent: () => 1);

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
                  saveSubjectsToHive();
                  Navigator.pop(context);
                },
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
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
          title: Center(child: Text("Update ${subjectList[index][0]}")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text("Hours: "),
                  Expanded(
                    child: InputTextField(
                      controller: hoursController,
                      label: '',
                    ),
                  ),
                  Text(" Minutes: "),
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
                      int hours =
                          int.tryParse(hoursController.text.trim()) ?? 0;
                      int minutes =
                          int.tryParse(minutesController.text.trim()) ?? 0;
                      int total = hours * 60 + minutes;

                      setState(() {
                        subjectList[index][3] = total;
                      });
                      saveSubjectsToHive();
                      Navigator.pop(context);
                    },
                  ),
                  Settingsbutton(
                    buttonString: "Cancel",
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void addSubjectDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController hoursController = TextEditingController();
    TextEditingController minutesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text("Add subject!", style: TextStyle(fontFamily: "Oswald")),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text("Name: "),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Subject Name",
                        filled: true,
                        fillColor: Colors.white,
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
                  Text("Hours: "),
                  Expanded(
                    child: InputTextField(
                      controller: hoursController,
                      label: '',
                    ),
                  ),
                  Text(" Minutes: "),
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
                          int.tryParse(minutesController.text.trim()) ?? 0;
                      int goalTime = hours * 60 + minutes;

                      setState(() {
                        subjectList.add([subjectName, false, 0, goalTime]);
                      });
                      saveSubjectsToHive();
                      Navigator.pop(context);
                    },
                  ),
                  Settingsbutton(
                    buttonString: "Cancel",
                    onTap: () => Navigator.pop(context),
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
        child: Icon(Icons.add),
        onPressed: addSubjectDialog,
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/HeatmapScreen");
            },
            icon: Icon(Icons.calendar_month, color: Colors.white),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/AuthScreen');
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: subjectList.length,
        itemBuilder: (context, index) {
          return TrackTile(
            subjectName: subjectList[index][0],
            onTap: () => timerStarted(index),
            settingsTap: () => settingsOpened(index),
            deleteTap: () => deleteSubject(index),
            timeSpent: subjectList[index][2],
            timeGoal: subjectList[index][3],
            timerStart: subjectList[index][1],
          );
        },
      ),
    );
  }
}
