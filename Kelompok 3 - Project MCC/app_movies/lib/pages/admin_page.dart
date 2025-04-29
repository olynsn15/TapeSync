import 'package:app_movies/Genres/action.dart';
import 'package:app_movies/Genres/all_movies.dart';
import 'package:app_movies/Genres/comedy.dart';
import 'package:app_movies/Genres/family_movies.dart';
import 'package:app_movies/Genres/horror.dart';
import 'package:app_movies/Genres/romance.dart';
import 'package:app_movies/Genres/thriller.dart';
import 'package:app_movies/api/api.dart';
import 'package:app_movies/components/video_card_widget.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late Future<List<Tape>> tapeList;

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
        title: Text(
          "Admin",
          style: GoogleFonts.afacad(
            textStyle:
                const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/crybaby.jpeg'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Hi, CryBaby',
                    style: TextStyle(
                      fontSize: 20,
                      color: backColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text(
                'Admin',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'insertAdmin');
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text(
                'Insert Product',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'insert');
              },
            ),
            const SizedBox(
              height: 425,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: primaryColor,
              ),
              title: const Text(
                'Log out',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'login');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        //child: Padding(
        //padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
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
            AllMoviesWidget(
              tapeList: tapeList,
              showSpeedDial: true,
            ),
            const SizedBox(height: 20),
            FamilyMoviesWidget(
              tapeList: fetchTape(genre: Genre.family),
              showSpeedDial: true,
            ),
            const SizedBox(height: 20),
            ComedyMoviesWidget(
              tapeList: fetchTape(genre: Genre.comedy),
              showSpeedDial: true,
            ),
            const SizedBox(height: 20),
            RomanceMoviesWidget(
              tapeList: fetchTape(genre: Genre.romance),
              showSpeedDial: true,
            ),
            const SizedBox(height: 20),
            HorrorMoviesWidget(
              tapeList: fetchTape(genre: Genre.horror),
              showSpeedDial: true,
            ),
            const SizedBox(height: 20),
            ThrillerMoviesWidget(
              tapeList: fetchTape(genre: Genre.thriller),
              showSpeedDial: true,
            ),
            const SizedBox(height: 20),
            ActionMoviesWidget(
              tapeList: fetchTape(genre: Genre.action),
              showSpeedDial: true,
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
