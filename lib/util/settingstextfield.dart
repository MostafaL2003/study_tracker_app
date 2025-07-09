import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({super.key, this.controller, required this.label});

  final controller;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration:  InputDecoration(
        labelText: label,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
