import 'package:app_movies/api/api.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardList extends StatefulWidget {
  final List<Tape> tapes;
  final Map<int, int> quantities; // Pass quantities from parent
  final Function(int, int) onQuantityChange; // Function to update quantities
  final Function(int) onProductRemove; // Function to remove product

  const ProductCardList({
    super.key,
    required this.tapes,
    required this.quantities,
    required this.onQuantityChange,
    required this.onProductRemove, // Add remove callback
  });

  @override
  State<ProductCardList> createState() => _ProductCardListState();
}

class _ProductCardListState extends State<ProductCardList> {
  Future<void> _showRemoveDialog(int tapeId, int index) async {
    final tape = widget.tapes.firstWhere((t) => t.id == tapeId);
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Remove ${tape.tapeTitle}?'),
            content: const Text(
                'Are you sure you want to remove this item from the basket?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.onProductRemove(
                        tapeId); // Notify parent to remove product
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  void _increaseQuantity(int tapeId) {
    final currentQuantity = widget.quantities[tapeId] ?? 1;
    widget.onQuantityChange(tapeId, currentQuantity + 1); // Update quantity
  }

  void _decreaseQuantity(int tapeId) {
    final currentQuantity = widget.quantities[tapeId] ?? 1;
    if (currentQuantity > 1) {
      widget.onQuantityChange(tapeId, currentQuantity - 1); // Update quantity
    } else {
      _showRemoveDialog(
          tapeId,
          widget.tapes.indexWhere((tape) =>
              tape.id == tapeId)); // Show remove dialog if quantity is 1
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.tapes.length,
      itemBuilder: (context, index) {
        final tape = widget.tapes[index];
        final quantity = widget.quantities[tape.id] ?? 1;

        return Container(
          height: 180,
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  image: tape.tapeImage.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage('$URLPATH${tape.tapeImage}'),
                          fit: BoxFit.fitWidth)
                      : null,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tape.tapeTitle,
                      style: GoogleFonts.afacad(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        tape.tapePrice,
                        style: GoogleFonts.afacad(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon:
                                    Icon(Icons.remove, size: 15, color: white),
                                onPressed: () => _decreaseQuantity(tape.id),
                              ),
                              Text(
                                '$quantity',
                                style: GoogleFonts.afacad(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: white),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, size: 15, color: white),
                                onPressed: () => _increaseQuantity(tape.id),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showRemoveDialog(tape.id, index),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
