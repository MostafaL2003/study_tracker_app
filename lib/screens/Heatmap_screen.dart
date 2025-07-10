import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:study_tracker_app/screens/home_screen.dart'; // assuming dailyStudyTime is from here

class HeatmapScreen extends StatefulWidget {
  const HeatmapScreen({super.key});

  @override
  State<HeatmapScreen> createState() => _HeatmapScreenState();
}

class _HeatmapScreenState extends State<HeatmapScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    int minutesToday = dailyStudyTime[today] ?? 0;
    minutesToday = minutesToday ~/ 60;

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
      body: Column(
        children: [
          Text(
            "Your Study Heatmap",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "Oswald",
            ),
          ),
          Center(
            child: HeatMapCalendar(
              datasets: dailyStudyTime,
              colorsets: {
                1: Colors.lightGreen[100]!,
                3: Colors.green[400]!,
                5: Colors.green[900]!,
              },
              defaultColor: Colors.grey[300],
              textColor: Colors.black,
              showColorTip: false,
              size: 40,
            ),
          ),
          SizedBox(height: 20),
          Builder(
            builder: (context) {
              return Column(
                children: [
                  Text(
                    "You studied $minutesToday minute${minutesToday == 1 ? '' : 's'} today.",
                    style: TextStyle(fontSize: 16, fontFamily: "Oswald"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Keep going 💪",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: "Oswald",
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
