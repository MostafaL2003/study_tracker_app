import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TrackTile extends StatelessWidget {
  final String subjectName;
  final VoidCallback onTap;
  final VoidCallback settingsTap;
  final VoidCallback deleteTap;
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
    required this.deleteTap,
  });

  // ✅ Proper time formatter: returns hh:mm:ss
  String formatTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    String h = hours.toString().padLeft(2, '0');
    String m = minutes.toString().padLeft(2, '0');
    String s = seconds.toString().padLeft(2, '0');

    return "$h:$m:$s";
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
          children: [
            // 👇 Timer button with progress
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

            // 👇 Subject and time text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subjectName,
                  style: TextStyle(fontSize: 30, fontFamily: "Oswald"),
                ),
                Text(
                  "${formatTime(timeSpent)} / ${formatTime(timeGoal * 60)} (${(percentCompleted() * 100).toStringAsFixed(0)}%)",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontFamily: "Oswald",
                  ),
                ),
              ],
            ),

            Spacer(),

            // 👇 Icons: settings and delete (basket style)
            Row(
              children: [
                IconButton(onPressed: settingsTap, icon: Icon(Icons.settings)),
                IconButton(
                  onPressed: deleteTap,
                  icon: Icon(Icons.delete_outline),
                  tooltip: "Delete",
                  color: Colors.redAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
