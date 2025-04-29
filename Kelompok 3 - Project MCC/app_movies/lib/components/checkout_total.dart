import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutTotal extends StatelessWidget {
  final int total;

  const CheckoutTotal({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your total',
            style: GoogleFonts.afacad(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: black,
            ),
          ),
          const SizedBox(
              height:
                  10), // Add a little space between the text and the total container
          Container(
            decoration: BoxDecoration(
              color: filled,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  'TOTAL',
                  style: GoogleFonts.afacad(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: black,
                  ),
                ),
                const Spacer(),
                Text(
                  'Rp $total',
                  style: GoogleFonts.afacad(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
