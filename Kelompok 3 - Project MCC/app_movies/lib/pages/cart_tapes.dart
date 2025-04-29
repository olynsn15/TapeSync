import 'package:app_movies/pages/detail_checkout.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_movies/models/tapes.dart';

class CartTapes extends StatefulWidget {
  final List<Tape> basket;

  const CartTapes({super.key, required this.basket});

  @override
  _CartTapesState createState() => _CartTapesState();
}

class _CartTapesState extends State<CartTapes> {
  late List<Tape> _basket;

  @override
  void initState() {
    super.initState();
    _basket = List.from(widget.basket); // Copy the basket list to _basket
  }

  // Function to handle adding to the cart and increasing quantity if needed
  void addToCart(Tape tape) {
    setState(() {
      bool exists = false;
      for (var item in _basket) {
        if (item.tapeTitle == tape.tapeTitle) {
          item.quantity++; // Increase quantity if the tape is already in the cart
          exists = true;
          break;
        }
      }
      if (!exists) {
        _basket.add(tape);
      }
    });
  }

  // Function to handle removing items from the cart
  void removeFromCart(Tape tape) {
    setState(() {
      _basket.remove(tape); // Remove the tape from the basket
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: const Text('Cart List'),
        backgroundColor: backColor,
      ),
      body: Column(
        children: [
          // List of products in the cart
          Expanded(
            child: ListView.builder(
              itemCount: _basket.length,
              itemBuilder: (context, index) {
                final tape = _basket[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  color: filled,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 60,
                            height: 90, // Image size
                            child: Image.network(
                              tape.tapeImage,
                              fit: BoxFit.cover, // Maintain image aspect ratio
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 12), // Space between image and text
                        // Other information
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tape.tapeTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text('Price: ${tape.tapePrice}'),
                              Text('⭐ ${tape.level.toString()}'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            removeFromCart(tape); // Call removeFromCart
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('${tape.tapeTitle} removed from cart'),
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Checkout button at the bottom
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailCheckoutPage(basket: _basket)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
