import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ElevatedButton(onPressed: (){Navigator.pushNamed(context, "/HomeScreen");}, child: Text("Login"))
    );
  }
}