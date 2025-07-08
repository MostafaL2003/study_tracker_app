import 'package:flutter/material.dart';

class Loginoptions extends StatelessWidget {
  const Loginoptions({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imagePath, height: 80),
        ),
      ),
    );
  }
}
