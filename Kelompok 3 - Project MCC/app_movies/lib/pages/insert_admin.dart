import 'package:app_movies/api/api.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';

class InsertAdmin extends StatefulWidget {
  const InsertAdmin({super.key});

  @override
  State<InsertAdmin> createState() => _InsertAdminState();
}

class _InsertAdminState extends State<InsertAdmin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  // Fungsi untuk menangani insert
  void handleInsert() async {
    String usernameAdmin = usernameController.text;
    String passwordAdmin = passwordController.text;
    String roleAdmin = roleController.text;

    if (usernameAdmin.isEmpty || passwordAdmin.isEmpty || roleAdmin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Fields cannot be empty'),
        backgroundColor: Colors.red,
      ));
      // toast("Fields cannot be empty!", context);
      return;
    }

    bool success =
        await insertAdmin(usernameAdmin, passwordAdmin, roleAdmin, context);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Admin data successfully inserted!'),
          backgroundColor: Colors.blue,
        ),
      );
      usernameController.clear();
      passwordController.clear();
      roleController.clear();
      // toast("Admin data successfully inserted!", context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to insert data admin'),
        backgroundColor: Colors.red,
      ));
      // toast("Failed to insert data admin.", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: filled,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Insert Admin",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  // Username Admin Field
                  _buildTextField(usernameController, "Username"),

                  const SizedBox(height: 10),

                  // Password Field
                  _buildTextField(passwordController, "Password"),

                  const SizedBox(height: 10),

                  // Password Field
                  _buildTextField(roleController, "Role"),

                  const SizedBox(height: 15),

                  // Button untuk menambahkan produk
                  _buildButton("Add Admin", handleInsert, primaryColor),
                ],
              ),
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
