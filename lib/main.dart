import 'package:flutter/material.dart';
import 'package:study_tracker_app/screens/Heatmap_screen.dart';
import 'package:study_tracker_app/screens/authentication.dart';
import 'package:study_tracker_app/screens/home_screen.dart';
import 'package:study_tracker_app/screens/login_screen.dart';
import 'package:study_tracker_app/screens/welcome_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ✅ Hive packages
import 'package:hive_flutter/hive_flutter.dart';
import 'models/subject_model.dart'; // Make sure the file name matches!

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ Initialize Hive
  await Hive.initFlutter();

  // ✅ Register the Hive adapter for your Subject model
  Hive.registerAdapter(SubjectAdapter());

  // ✅ Open the Hive box where subjects will be stored
  await Hive.openBox<Subject>('subjectsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
      routes: {
        '/WelcomeScreen': (context) => const WelcomeScreen(),
        '/HomeScreen': (context) => const HomeScreen(),
        '/LoginScreen': (context) => LoginScreen(onTap: () {}),
        '/HeatmapScreen': (context) => const HeatmapScreen(),
        '/AuthScreen': (context) => const Auth(),
      },
    );
  }
}
