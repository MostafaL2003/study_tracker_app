import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_tracker_app/util/button.dart';
import 'package:study_tracker_app/util/loginOptions.dart';
import 'package:study_tracker_app/util/textfield.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key, this.onTap});

  final Function()? onTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  void signUserIn() async {
    try {
      if (passwordController.text == confirmController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Passwords don't match")));
        return; // Stop execution if passwords don't match
      }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Center(
                child: Image.asset("assets/image/profile.png", height: 200),
              ),
              SizedBox(height: 10),
              Text(
                "Create an account !",
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
              SizedBox(height: 10),
              MyTextField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: confirmController,
              ),
              SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.end),
              SizedBox(height: 30),
              MyButton(onTap: signUserIn, text: "Sign up"),
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
                  Text("Already have an account ?"),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 30, 110, 177),
                        fontWeight: FontWeight.bold,
                      ),
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
      ),
    );
  }
}
