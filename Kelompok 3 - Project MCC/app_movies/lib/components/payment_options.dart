import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_movies/models/tapes.dart'; // Ensure this import if Tape is a custom model

class PaymentOptions extends StatelessWidget {
  final List<Tape> basket;
  final double subtotal;

  // Constructor untuk menerima basket dan subtotal
  const PaymentOptions({
    Key? key,
    required this.basket,
    required this.subtotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gabungkan kuantitas tape yang sama berdasarkan tapeTitle
    Map<String, Tape> aggregatedBasket = {};
    for (var tape in basket) {
      if (aggregatedBasket.containsKey(tape.tapeTitle)) {
        aggregatedBasket[tape.tapeTitle]!.quantity +=
            tape.quantity; // Gabungkan kuantitas
      } else {
        aggregatedBasket[tape.tapeTitle] = tape;
      }
    }

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        title: const Text('Payment Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 35.0, right: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basket Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Daftar item dalam basket
            Expanded(
              child: ListView.builder(
                itemCount: aggregatedBasket.length,
                itemBuilder: (context, index) {
                  final tape = aggregatedBasket.values.elementAt(index);
                  return ListTile(
                    title: Text(tape.tapeTitle),
                    subtitle: Text('Quantity: ${tape.quantity}'),
                    trailing: Text('Rp. ${tape.tapePrice * tape.quantity}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Subtotal: Rp. $subtotal',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'thankyou');
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
                    'Points',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'thankyou');
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
                    'Gopay',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
