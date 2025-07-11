import 'package:flutter/material.dart';
import 'package:study_tracker_app/screens/Heatmap_screen.dart';
import 'package:study_tracker_app/screens/home_screen.dart';
import 'package:study_tracker_app/screens/login_screen.dart';
import 'package:study_tracker_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      routes: {
        '/WelcomeScreen': (context) => const WelcomeScreen(),
        '/HomeScreen': (context) => const HomeScreen(),
        '/LoginScreen':(context) =>  LoginScreen(),
        '/HeatmapScreen': (context) => HeatmapScreen(),
      },
    );
  }
}

