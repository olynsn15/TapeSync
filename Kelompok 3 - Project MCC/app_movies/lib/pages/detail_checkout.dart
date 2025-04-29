import 'package:app_movies/components/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:intl/intl.dart';

class DetailCheckoutPage extends StatefulWidget {
  final List<Tape> basket;

  const DetailCheckoutPage({super.key, required this.basket});

  @override
  _DetailCheckoutPageState createState() => _DetailCheckoutPageState();
}

class _DetailCheckoutPageState extends State<DetailCheckoutPage> {
  late List<Tape> _basket;

  @override
  void initState() {
    super.initState();
    _basket = List.from(widget.basket); // Copy the basket list to _basket
  }

  // Function to handle adding quantity
  void addQuantity(Tape tape) {
    setState(() {
      tape.quantity++;
    });
  }

  // Function to handle reducing quantity
  void reduceQuantity(Tape tape) {
    setState(() {
      if (tape.quantity > 1) {
        tape.quantity--;
      }
    });
  }

  // Function to handle removing items from the cart
  void removeFromCart(Tape tape) {
    setState(() {
      _basket.remove(tape); // Remove the tape from the basket
    });
  }

  // Calculate the subtotal, shipping fee, and total amount
  // Helper function to parse price string (e.g., "Rp. 100,000" -> 100000)
  double parsePrice(String priceString) {
    // Remove the 'Rp.' prefix and commas
    String priceWithoutRp = priceString.replaceAll(RegExp(r'[^\d]'), '');

    // Convert to double
    return double.tryParse(priceWithoutRp) ??
        0.0; // Default to 0.0 if parsing fails
  }

// Update the calculateSubtotal() method
  double calculateSubtotal() {
    double subtotal = 0;
    for (var tape in _basket) {
      double price = parsePrice(tape.tapePrice);
      subtotal += price * tape.quantity;
    }
    return subtotal;
  }

  double calculateShippingFee() {
    return 50000;
  }

  double calculateTotalAmount() {
    return calculateSubtotal() + calculateShippingFee();
  }

  String formatCurrency(int amount) {
    final NumberFormat currencyFormat = NumberFormat('#,##0', 'id_ID');
    return 'Rp. ${currencyFormat.format(amount)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: const Text('Detail Checkout'),
        backgroundColor: backColor,
      ),
      body: Column(
        children: [
          // Product List
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
                            height: 90,
                            child: Image.network(
                              tape.tapeImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Product Information
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
                              Text('⭐ ${tape.level}'),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () => reduceQuantity(tape),
                                  ),
                                  Text('${tape.quantity}'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => addQuantity(tape),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Delete Button
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            removeFromCart(tape);
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
          // Payment Amount Card
          Card(
            margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            color: filled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Subtotal:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('\Rp. ${calculateSubtotal()}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Shipping Fee:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('\Rp. ${calculateShippingFee()}'),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('\Rp. ${calculateTotalAmount()}'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentOptions(
                              basket: _basket, subtotal: calculateSubtotal()),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Go to Payment',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
