import 'package:app_movies/api/api.dart';
import 'package:app_movies/components/list_card_basket.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/pages/cart_tapes.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  List<Tape> tapes = []; // List of all tapes fetched from the backend
  List<Tape> basket = []; // List to store items added to the basket

  @override
  void initState() {
    super.initState();
    _loadTapes();
  }

  // Function to fetch tapes from the backend
  Future<void> _loadTapes() async {
    try {
      List<Tape> fetchedTapes = await fetchTape();
      setState(() {
        tapes = fetchedTapes;
      });
    } catch (e) {
      print('Error loading tapes: $e');
    }
  }

  Future<void> navigateToPaymentList() async {
    final updatedBasket = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartTapes(basket: basket),
      ),
    );

    if (updatedBasket != null) {
      setState(() {
        basket =
            updatedBasket; // Update the basket with the updated list from PaymentList
      });
    }
  }

  // Function to add a tape to the basket
  void addToBasket(Tape tape) {
    setState(() {
      basket.add(tape); // Add the selected tape to the basket
    });
  }

  void updateBasket(List<Tape> updatedBasket) {
    setState(() {
      basket = updatedBasket; // Update the basket with the new list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        title: Text(
          'Cart Page',
          style: GoogleFonts.afacad(
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: navigateToPaymentList,
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: tapes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Display the list of products
                  Expanded(
                    child: ListCardBasket(
                      tapes: tapes,
                      addToBasket: addToBasket, // Pass the addToBasket function
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
