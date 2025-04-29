import 'dart:io';

import 'package:app_movies/api/api.dart';
import 'package:app_movies/helper/toast.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InsertProductPage extends StatefulWidget {
  const InsertProductPage({super.key});

  @override
  State<InsertProductPage> createState() => _InsertProductPageState();
}

class _InsertProductPageState extends State<InsertProductPage> {
  TextEditingController tapeTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tapePriceController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  File? image;
  Genre? selectedGenre; // Menyimpan genre yang dipilih

  // Fungsi untuk menangani insert
  void handleInsert() async {
    String tapeTitle = tapeTitleController.text;
    String description = descriptionController.text;
    String tapePrice = tapePriceController.text;
    String levelText = levelController.text;

    if (tapeTitle.isEmpty ||
        description.isEmpty ||
        tapePrice.isEmpty ||
        levelText.isEmpty) {
      toast("Fields cannot be empty!", context);
      return;
    }
    if (image == null) {
      toast("You need to select an image!", context);
      return;
    }
    if (selectedGenre == null) {
      toast("Please select a genre!", context);
      return;
    }

    double? level = double.tryParse(levelText);
    if (level == null || level < 0 || level > 5) {
      toast("Please enter a valid rating between 0 and 5", context);
      return;
    }

    bool success = await insertTape(tapeTitle, description, tapePrice, image,
        selectedGenre!, level, context);

    if (success) {
      toast("Product successfully inserted!", context);
    } else {
      toast("Failed to insert product.", context);
    }
  }

  // Fungsi untuk memilih gambar
  Future pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: filled,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Insert Product",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image Preview
                SizedBox(
                  height: 200,
                  width: 250,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(10.0),
                      image: image == null
                          ? const DecorationImage(
                              image: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                              ),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: FileImage(image!),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Product Name Field
                _buildTextField(tapeTitleController, "Title"),

                const SizedBox(height: 10),

                // Product Title Field
                _buildTextField(descriptionController, "Description"),

                const SizedBox(height: 10),

                // Description Field
                _buildTextField(tapePriceController, "Price"),

                const SizedBox(height: 10),

                // Rating Field
                _buildTextField(levelController, "Rating"),

                const SizedBox(height: 10),

                // Dropdown untuk memilih genre
                DropdownButtonFormField<Genre>(
                  value: selectedGenre,
                  isDense: true,
                  hint: const Text("Select Genre"),
                  //isDense: true,
                  items: Genre.values.map((Genre genre) {
                    return DropdownMenuItem<Genre>(
                      value: genre,
                      child:
                          Text(genre.toString().split('.').last.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (Genre? newValue) {
                    setState(() {
                      selectedGenre = newValue;
                    });
                  },
                  menuMaxHeight: 150,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  dropdownColor: Colors.white,
                ),

                const SizedBox(height: 20),

                // Button untuk memilih gambar
                _buildButton("Pick Image", pickImage, secondColor),

                const SizedBox(height: 15),

                // Button untuk menambahkan produk
                _buildButton("Insert Product", handleInsert, primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat TextField
  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat tombol
  Widget _buildButton(String text, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
