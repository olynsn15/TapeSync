import 'package:app_movies/api/api.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  final Tape tape;
  final Function(Tape) addToBasket;

  const DetailScreen(
      {super.key, required this.tape, required this.addToBasket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: filled,
        title: Text(
          tape.tapeTitle,
          style: GoogleFonts.afacad(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tape Image
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: tape.tapeImage.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage('$URLPATH${tape.tapeImage}'),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 16),
            // Tape Name
            Text(
              tape.tapeTitle,
              style: GoogleFonts.afacad(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Add to Basket Button
            ElevatedButton(
              onPressed: () {
                addToBasket(tape); // Add the tape to the basket
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${tape.tapeTitle} added to the basket!'),
                  ),
                );
                Navigator.pop(context); // Return to the previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Add to Basket',
                style: GoogleFonts.afacad(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
