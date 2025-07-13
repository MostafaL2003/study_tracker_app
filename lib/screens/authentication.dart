import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_tracker_app/screens/home_screen.dart';
import 'package:study_tracker_app/screens/login_or_register.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen(); // User is logged in
        } else {
          return LoginOrRegister(); // Show login/register logic
        }
      },
    );
  }
}
