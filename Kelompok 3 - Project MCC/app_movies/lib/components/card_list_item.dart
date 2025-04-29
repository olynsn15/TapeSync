import 'package:app_movies/api/api.dart';
import 'package:app_movies/components/popup_form.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ItemListWidget extends StatefulWidget {
  final Future<List<Tape>> tapeList;

  const ItemListWidget({super.key, required this.tapeList});

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Tape>>(
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

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tapes.length,
          itemBuilder: (context, index) {
            final tape = tapes[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('$URLPATH${tape.tapeImage}'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 20,
                    child: Text(
                      tape.tapeTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 155,
                    left: 20,
                    child: Text(
                      tape.tapeTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
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
                      child: const Icon(Icons.auto_awesome_motion_outlined),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
