import 'package:app_movies/api/api.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/pages/detail_page.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListCardBasket extends StatefulWidget {
  final List<Tape> tapes;
  final Function(Tape) addToBasket; // Callback to notify parent of added item

  const ListCardBasket({
    super.key,
    required this.tapes,
    required this.addToBasket, // Required callback
  });

  @override
  State<ListCardBasket> createState() => _ListCardBasketState();
}

class _ListCardBasketState extends State<ListCardBasket> {
  late Future<List<Tape>> tapesFuture;

  @override
  void initState() {
    super.initState();
    tapesFuture =
        fetchTape(); // Fetch tapes from the API when widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Tape>>(
      future: tapesFuture, // The future we need to resolve
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tapes available.'));
        }

        final tapes = snapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: tapes.length,
          itemBuilder: (context, index) {
            final tape = tapes[index];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Tape Image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: tape.tapeImage.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage('$URLPATH${tape.tapeImage}'),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Tape Name and Price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tape.tapeTitle,
                          style: GoogleFonts.afacad(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tape.tapePrice,
                          style: GoogleFonts.afacad(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Add to Basket Button
                  Row(
                    children: [
                      // Navigate to Detail Screen Button
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  tape: tape,
                                  addToBasket: widget.addToBasket,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.info_outline,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
