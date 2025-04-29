import 'package:app_movies/api/api.dart';
import 'package:app_movies/components/outlined_text.dart';
import 'package:app_movies/components/popup_form.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/pages/checkout_page.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';

class AllMoviesWidget extends StatefulWidget {
  final Future<List<Tape>> tapeList;
  final bool showSpeedDial;

  const AllMoviesWidget(
      {super.key, required this.tapeList, this.showSpeedDial = false});

  @override
  State<AllMoviesWidget> createState() => _AllMoviesWidgetState();
}

class _AllMoviesWidgetState extends State<AllMoviesWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text di atas list
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 20),
          child: Text(
            'All Movies',
            style: GoogleFonts.abhayaLibre(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),

        // FutureBuilder untuk memuat data
        FutureBuilder<List<Tape>>(
          future: widget.tapeList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No items available.'));
            }

            final tapes = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CarouselSlider.builder(
                itemCount: tapes.length,
                options: CarouselOptions(
                  height: 338, // Tinggi Carousel
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: false, // Auto-scroll dinonaktifkan
                  viewportFraction: 0.5,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index; // Update indeks tengah
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  final tape = tapes[index];
                  final bool isCenter = index == _currentIndex;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                              title: tape.tapeTitle,
                              image: '$URLPATH${tape.tapeImage}',
                              description: tape.description,
                              genre: tape.genre,
                              price: tape.tapePrice,
                              level: tape.level),
                        ),
                      );
                    },
                    // width: 280, // Lebar spesifik untuk setiap Card
                    // child: Card(
                    //   elevation: 5,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    // child: Container(
                    //   decoration: BoxDecoration(
                    //     color: isCenter ? Colors.white : Colors.transparent,
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    child: Stack(
                      children: [
                        // Gambar produk
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            height: 280, // Tinggi gambar agar portrait
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    NetworkImage('$URLPATH${tape.tapeImage}'),
                                fit: BoxFit.cover, // Gambar memenuhi container
                              ),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                                bottom: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        if (isCenter) ...[
                          Positioned(
                            bottom: 23,
                            left: 5,
                            child: OutlinedText(
                              text: tape.tapeTitle,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              outlineColor: filled,
                              textColor: Colors.black,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 5,
                            child: Text(
                              '(${tape.tapeYear})',
                              style: GoogleFonts.afacad(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          if (isCenter && widget.showSpeedDial) ...[
                            Positioned(
                              bottom: 70,
                              right: 10,
                              child: SpeedDial(
                                backgroundColor: primaryColor,
                                overlayColor: Colors.black,
                                overlayOpacity: 0.4,
                                spacing: 3,
                                spaceBetweenChildren: 3,
                                activeIcon: Icons.close,
                                children: [
                                  SpeedDialChild(
                                    child: const Icon(Icons.edit),
                                    shape: const CircleBorder(),
                                    onTap: () {
                                      PopupForm.show(context, 'Edit', tape);
                                    },
                                  ),
                                  SpeedDialChild(
                                    child: const Icon(Icons.delete),
                                    shape: const CircleBorder(),
                                    onTap: () {
                                      PopupForm.show(context, 'Delete', tape);
                                    },
                                  ),
                                ],
                                child: const Icon(
                                    Icons.auto_awesome_motion_outlined),
                              ),
                            ),
                          ]
                        ]
                        // Teks produk (Nama dan Judul)
                      ],
                    ),
                  );
                  //);
                  //);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
