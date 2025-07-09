import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TrackTile extends StatelessWidget {
  final String subjectName;
  final VoidCallback onTap;
  final VoidCallback settingsTap;
  final int timeSpent;
  final int timeGoal;
  final bool timerStart;

  const TrackTile({
    super.key,
    required this.subjectName,
    required this.onTap,
    required this.settingsTap,
    required this.timeSpent,
    required this.timeGoal,
    required this.timerStart,
  });

  String minToSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(4);
    String hours = (totalSeconds / 60 / 60).toStringAsFixed(4);

    if (secs.length == 1) {
      secs = "0$secs";
    }
    if (hours[1] == '.') {
      hours = hours.substring(0, 1);
    }
    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }

    return "$hours:$mins:$secs";
  }

  double percentCompleted() {
    return (timeSpent / (timeGoal * 60)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: CircularPercentIndicator(
                    progressColor: Colors.green,
                    percent: percentCompleted(),
                    radius: 40,
                    center: Icon(
                      timerStart ? Icons.pause : Icons.play_arrow,
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subjectName,
                      style: TextStyle(fontSize: 30, fontFamily: "Oswald"),
                    ),
                    Text(
                      "${minToSec(timeSpent)}-$timeGoal-${(percentCompleted() * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                        fontFamily: "Oswald",
                      ),
                    ),
                  ],
                ),
              ],
            ),

            GestureDetector(onTap: settingsTap, child: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
