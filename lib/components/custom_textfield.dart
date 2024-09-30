import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomTextfield({
    super.key,
    required this.label,
    required this.controller,
  });

   @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label, // Label text inside the TextField
        labelStyle: TextStyle(color: Colors.grey[700]), // Label text color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          borderSide: const BorderSide(
            color: Colors.grey, // Thin border color
            width: 1.0, // Border thickness
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.grey, // Color of the border when not focused
            width: 1.0, // Border thickness
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.deepPurple, // Color of the border when focused
            width: 1.0, // Border thickness
          ),
        ),
      ),
    );
  }
}
