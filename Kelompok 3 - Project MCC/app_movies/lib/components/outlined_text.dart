import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color outlineColor;
  final Color textColor;

  const OutlinedText({
    super.key,
    required this.text,
    this.fontSize = 18.0,
    this.fontWeight = FontWeight.w500,
    this.outlineColor = Colors.black,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Outline
        Text(
          text,
          style: GoogleFonts.afacad(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2.5
              ..color = outlineColor, // Warna outline
          ),
        ),
        // Fill text
        Text(
          text,
          style: GoogleFonts.afacad(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor, // Warna teks
          ),
        ),
      ],
    );
  }
}
