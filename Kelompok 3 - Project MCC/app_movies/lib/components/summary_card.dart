import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryCard extends StatelessWidget {
  final int subtotal;

  const SummaryCard({super.key, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: filled,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(25),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PAYMENT AMOUNT',
                style: GoogleFonts.afacad(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'SUB TOTAL',
                    style: GoogleFonts.afacad(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Rp $subtotal',
                    style: GoogleFonts.afacad(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'SHIPPING FEE',
                    style: GoogleFonts.afacad(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Rp 11000',
                    style: GoogleFonts.afacad(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(thickness: 1, color: Colors.black),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'TOTAL',
                    style: GoogleFonts.afacad(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Rp ${subtotal + 11000}', // Include shipping fee
                    style: GoogleFonts.afacad(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
