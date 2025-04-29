import 'dart:convert';

import 'package:app_movies/components/button.dart';
import 'package:app_movies/components/square_title.dart';
import 'package:app_movies/components/textfields.dart';
import 'package:app_movies/models/googleAPI.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'jwt_token', value: token);
  }

  Future<void> loginUser() async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (password.isNotEmpty && username.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:4000/users/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': username,
            'password': password,
          }),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          String token = data['token'];

          await saveToken(token);
          Navigator.pushReplacementNamed(context, 'home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Failed: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              //Create your account
              Text(
                "Log in to your account",
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
                    //Don't have an account? Register
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                          text: "Register",
                          style: GoogleFonts.afacad(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, 'register');
                            }),
                    ]),
              ),
              const SizedBox(
                height: 60,
              ),
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
                    //password text field
                    Textfields(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: (password) => password!.length < 8
                          ? 'Password must be at least 8 characters long'
                          : null,
                    ),
                    //Forgot Password
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 37.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey[600],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //Register Button
              Button(
                button: 'Login',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    loginUser();
                  }
                },
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 55,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      signInGoogle(context);
                    },
                    child: const SquareTitle(imagePath: 'assets/google.png'),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              //not a member, register now
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
                      const TextSpan(text: "Not a member "),
                      TextSpan(
                          text: "Register now",
                          style: GoogleFonts.afacad(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, 'register');
                            }),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
