import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/tapes.dart';
import 'cart_tapes.dart';
import '../shared/theme.dart';

class CheckoutPage extends StatefulWidget {
  final String title;
  final String image;
  final String price;
  final String description;
  final Genre genre;
  final double level;

  const CheckoutPage({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.genre,
    required this.level,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<Tape> basket = [];

  // Fungsi untuk menavigasi ke PaymentList
  void navigateToPaymentList() async {
    // Navigasi ke CartTapes dan tunggu untuk mendapatkan hasil (basket)
    final updatedBasket = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartTapes(basket: basket),
      ),
    );

    // Jika updatedBasket tidak null, maka perbarui basket
    if (updatedBasket != null) {
      setState(() {
        basket = updatedBasket;
      });
    }
  }

  // Fungsi untuk menambahkan ke keranjang dan menampilkan snackbar
  void addToBasket() {
    setState(() {
      basket.add(
        Tape(
          id: 1,
          tapeYear: DateTime.now().year,
          tapeTitle: widget.title,
          description: widget.description,
          tapePrice: widget.price,
          tapeImage: widget.image,
          genre: widget.genre,
          level: widget.level,
        ),
      );
    });

    // Tampilkan Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: const Text("Added to Basket"),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String genreName = widget.genre.toString().split('.').last;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        title: const Text('Detail Informations'),
        actions: [
          // Ikon Shopping Bag untuk navigasi ke PaymentList
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  onPressed: navigateToPaymentList, // Navigasi ke PaymentList
                ),
                // Badge untuk jumlah item di keranjang
                if (basket.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        basket.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image dan Detail Produk
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.image,
                        height: 180,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          genreName,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 10),
                        RatingBarIndicator(
                          rating: widget.level,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 24.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Synopsis',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 40),
              const Text(
                'PRICE',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildPriceRow('Item price', widget.price),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Menempatkan tombol di tengah
                children: [
                  // Tombol Cancel
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          secondColor, // Warna latar belakang untuk tombol cancel
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      shadowColor: const Color.fromARGB(255, 254, 243, 148),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Tombol Add to Cart
                  ElevatedButton(
                    onPressed:
                        addToBasket, // Fungsi yang akan dijalankan ketika tombol ditekan
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .deepOrange, // Warna latar belakang untuk tombol Add to Cart
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      shadowColor: Colors.deepOrangeAccent,
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan harga
  Widget _buildPriceRow(String text, String price) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 244, 188, 165),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(fontSize: 16)),
          Text(price, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
