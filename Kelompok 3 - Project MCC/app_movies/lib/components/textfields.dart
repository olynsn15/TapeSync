import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';

class Textfields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const Textfields({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondColor),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: filled,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 13.0, // Sesuaikan padding vertikal
            horizontal: 15.0, // Sesuaikan padding horizontal
          ),
        ),
      ),
    );
  }
}
