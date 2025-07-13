import 'package:flutter/material.dart';
import 'package:study_tracker_app/screens/login_screen.dart';
import 'package:study_tracker_app/screens/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
      print("Toggled to: ${showLoginPage ? "Login" : "Register"}");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding LoginOrRegister: showLoginPage = $showLoginPage");

    return Scaffold(
      body:
          showLoginPage
              ? LoginScreen(onTap: togglePages)
              : RegisterScreen(onTap: togglePages),
    );
  }
}
