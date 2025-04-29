import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';

class SquareTitle extends StatelessWidget {
  final String imagePath;
  const SquareTitle({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: white),
        borderRadius: BorderRadius.circular(16),
        color: filled,
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
