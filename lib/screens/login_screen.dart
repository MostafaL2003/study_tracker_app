import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_tracker_app/util/button.dart';
import 'package:study_tracker_app/util/loginOptions.dart';
import 'package:study_tracker_app/util/textfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  void logUserIn() async {
    try {
      // Add await here to ensure auth completes before navigation
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Add await for navigation too
      await Navigator.pushReplacementNamed(context, "/HomeScreen");
    } on FirebaseAuthException catch (e) {
      print('Login failed: ${e.message}');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Center(child: Image.asset("assets/image/profile.png", height: 200)),
            SizedBox(height: 10),
            Text(
              "Welcome back !",
              style: TextStyle(fontFamily: "Oswald", fontSize: 20),
            ),
            SizedBox(height: 20),
            MyTextField(
              hintText: 'Email',
              obscureText: false,
              controller: usernameController,
            ),
            SizedBox(height: 10),
            MyTextField(
              hintText: 'Password',
              obscureText: true,
              controller: passwordController,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("Forgot Password"),
                ),
              ],
            ),
            SizedBox(height: 30),
            MyButton(onTap: logUserIn),
            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey[500], thickness: 0.5),
                  ),
                  Text("Or login with"),
                  Expanded(
                    child: Divider(color: Colors.grey[500], thickness: 0.5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Loginoptions(imagePath: 'assets/image/google.png'),
                Loginoptions(imagePath: 'assets/image/apple.png'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have an account ? "),
                Text(
                  "Register now",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 30, 110, 177),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // TEMP BUTTON TO NAVIGATE
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/HomeScreen");
              },
              child: Text("Temp"),
            ),
            //
          ],
        ),
      ),
    );
  }
}
