import 'package:app_movies/Genres/action.dart';
import 'package:app_movies/Genres/all_movies.dart';
import 'package:app_movies/Genres/comedy.dart';
import 'package:app_movies/Genres/family_movies.dart';
import 'package:app_movies/Genres/horror.dart';
import 'package:app_movies/Genres/romance.dart';
import 'package:app_movies/Genres/thriller.dart';
import 'package:app_movies/api/api.dart';
import 'package:app_movies/components/video_card_widget.dart';
import 'package:app_movies/models/googleAPI.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/pages/cart_tapes.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Tape>> tapeList;
  List<Tape> tapes = [];
  List<Tape> basket = [];

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
  void initState() {
    super.initState();
    tapeList = fetchTape();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        title: const Text('TapeSync'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            signOutGoogle();
            //Navigator.pushNamed(context, 'login');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You have logged out...'),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.shopping_bag_outlined),
              onPressed: () {
                print("Shopping cart clicked!");
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        //child: Padding(
        //padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: const [
                  VideoCardWidget(
                    imagePath: 'assets/trendingTape.jpeg',
                  ),
                  VideoCardWidget(
                    imagePath: 'assets/newTape.jpeg',
                  ),
                  VideoCardWidget(
                    imagePath: 'assets/newTape2.jpeg',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AllMoviesWidget(tapeList: tapeList),
            const SizedBox(height: 20),
            FamilyMoviesWidget(tapeList: fetchTape(genre: Genre.family)),
            const SizedBox(height: 20),
            ComedyMoviesWidget(tapeList: fetchTape(genre: Genre.comedy)),
            const SizedBox(height: 20),
            RomanceMoviesWidget(tapeList: fetchTape(genre: Genre.romance)),
            const SizedBox(height: 20),
            HorrorMoviesWidget(tapeList: fetchTape(genre: Genre.horror)),
            const SizedBox(height: 20),
            ThrillerMoviesWidget(tapeList: fetchTape(genre: Genre.thriller)),
            const SizedBox(height: 20),
            ActionMoviesWidget(tapeList: fetchTape(genre: Genre.action)),
          ],
        ),
      ),
    );
    //);
  }
}
