import 'package:app_movies/pages/home_page.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankyouPage extends StatefulWidget {
  const ThankyouPage({super.key});

  @override
  State<ThankyouPage> createState() => _ThankyouPageState();
}

class _ThankyouPageState extends State<ThankyouPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful! Thank you for your purchase.'),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: black,
              size: 20,
            ),
          ),
        ),
        title: Text(
          'TapeSync',
          style: GoogleFonts.afacad(
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(
              Icons.check,
              size: 100,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Thank you for shopping with us!',
              style: GoogleFonts.afacad(
                fontWeight: FontWeight.w600,
                fontSize: 40,
                color: black,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: primaryColor),
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Back to Home Page',
                      style: GoogleFonts.afacad(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
