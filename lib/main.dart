import 'package:flutter/material.dart';
import 'package:study_tracker_app/screens/Heatmap_screen.dart';
import 'package:study_tracker_app/screens/authentication.dart';
import 'package:study_tracker_app/screens/home_screen.dart';
import 'package:study_tracker_app/screens/login_screen.dart';
import 'package:study_tracker_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        '/LoginScreen': (context) => LoginScreen(onTap: () {}),
        '/HeatmapScreen': (context) => HeatmapScreen(),
        '/AuthScreen': (context) => Auth(),
      },
    );
  }
}
