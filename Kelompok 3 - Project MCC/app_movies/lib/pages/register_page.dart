import 'dart:convert';

import 'package:app_movies/components/button.dart';
import 'package:app_movies/components/textfields.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

//text editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void registerUser() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (_formKey.currentState!.validate()) {
      try {
        var url = Uri.parse('http://127.0.0.1:4000/users/register');
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': username,
            'email': email,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
          Navigator.pushReplacementNamed(context, 'login');
        } else {
          var errorMsg =
              jsonDecode(response.body)['message'] ?? 'Registration failed';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMsg)),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              //Create your account
              Text(
                "Create your account",
                style: GoogleFonts.afacad(
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              RichText(
                text: TextSpan(
                    style: GoogleFonts.afacad(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    //Already have an account? Log in
                    children: [
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                          text: "Log in",
                          style: GoogleFonts.afacad(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, 'login');
                            }),
                    ]),
              ),
              const SizedBox(
                height: 60,
              ),
              //username textfield
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Textfields(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false,
                      validator: (username) {
                        if (username == null || username.isEmpty) {
                          return "Username can't be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //email textfield
                    Textfields(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Email can\'t be empty';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(email)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //password text field
                    Textfields(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: (password) => password!.length < 8
                          ? 'Password must be at least 8 characters long'
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //Register Button
              Button(
                button: 'Register',
                onTap: registerUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
