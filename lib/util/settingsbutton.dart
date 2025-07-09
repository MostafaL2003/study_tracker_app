import 'package:flutter/material.dart';

class Settingsbutton extends StatelessWidget {
  const Settingsbutton({
    super.key,
    required this.buttonString,
    required this.onTap,
  });

  final String buttonString;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      onPressed: onTap,
      child: Text(
        buttonString,
        style: TextStyle(fontFamily: "Oswald", color: Colors.white),
      ),
    );
  }
}
