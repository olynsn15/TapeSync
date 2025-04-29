// import 'package:app_movies/components/product_card.dart';
// import 'package:app_movies/components/summary_card.dart';
// import 'package:app_movies/models/purchase.dart';
// import 'package:app_movies/models/tapes.dart';
// import 'package:app_movies/pages/detail_checkout.dart';
// import 'package:app_movies/shared/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class PaymentList extends StatefulWidget {
//   final List<Tape> basket; // Accept basket list

//   const PaymentList({super.key, required this.basket});

//   @override
//   State<PaymentList> createState() => _PaymentListState();
// }

// class _PaymentListState extends State<PaymentList> {
//   late List<Tape> tapes;
//   int subtotal = 0;
//   Map<int, int> quantities = {}; // Track quantities for each tape

//   @override
//   void initState() {
//     super.initState();
//     tapes = widget.basket.where((tape) => tape.tapePrice.isNotEmpty).toList();
//     for (final tape in tapes) {
//       quantities[tape.id] = 1; // Initialize quantities
//     }
//     _calculateSubtotal();
//   }

//   void updateQuantity(int tapeId, int quantity) {
//     setState(() {
//       quantities[tapeId] = quantity;
//     });
//     _calculateSubtotal();
//   }

//   void removeProduct(int tapeId) {
//     setState(() {
//       tapes.removeWhere((tape) => tape.id == tapeId); // Remove by tape ID
//       quantities.remove(tapeId); // Remove quantity using tape ID
//     });
//     _calculateSubtotal();
//   }

//   void goBackToHome() {
//     Navigator.pop(
//         context, tapes); // Pass the updated basket list back to HomePage
//   }

//   void _calculateSubtotal() {
//     int newSubtotal = 0;
//     for (final tape in tapes) {
//       final quantity = quantities[tape.id] ?? 1;
//       newSubtotal += int.parse(tape.tapePrice) * quantity;
//     }
//     setState(() {
//       subtotal = newSubtotal;
//     });
//   }

//   List<Purchase> _createPurchaseList() {
//     final purchases = <Purchase>[];
//     for (final tape in tapes) {
//       final quantity = quantities[tape.id] ?? 1;
//       purchases.add(Purchase(tapeId: tape.id, quantity: quantity));
//     }
//     return purchases;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backColor,
//       appBar: AppBar(
//         backgroundColor: filled,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 25),
//           child: IconButton(
//             onPressed: () =>
//                 goBackToHome(), // Navigate back and pass updated basket
//             icon: const Icon(Icons.arrow_back_ios_rounded,
//                 color: Colors.black, size: 20),
//           ),
//         ),
//         title: Text('Detail Informations',
//             style: GoogleFonts.afacad(
//                 fontWeight: FontWeight.w600, fontSize: 28, color: black)),
//         centerTitle: true,
//       ),
//       body: tapes.isEmpty
//           ? const Center(child: Text('Your basket is empty.'))
//           : Container(
//               margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Expanded(
//                     child: ProductCardList(
//                       tapes: tapes,
//                       quantities:
//                           quantities, // Pass quantities to ProductCardList
//                       onQuantityChange: updateQuantity, // Pass update function
//                       onProductRemove: removeProduct, // Pass remove function
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   SummaryCard(subtotal: subtotal),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: OutlinedButton(
//                         onPressed: () {
//                           final purchases = _createPurchaseList();
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                             builder: (context) => Checkout(
//                                   purchases: purchases,
//                                   total: subtotal + 11000),
//                             ),
//                           );
//                         },
//                         style: OutlinedButton.styleFrom(
//                           side: BorderSide(color: primaryColor),
//                           backgroundColor: primaryColor,
//                           padding: const EdgeInsets.all(20),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20)),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('Checkout',
//                                 style: GoogleFonts.afacad(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 28,
//                                     color: white)),
//                             const SizedBox(width: 50),
//                             const Icon(Icons.arrow_forward,
//                                 color: Colors.white, size: 30),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }