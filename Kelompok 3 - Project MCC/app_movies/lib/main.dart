import 'package:app_movies/components/payment_options.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/pages/admin_page.dart';
import 'package:app_movies/pages/basket_page.dart';
import 'package:app_movies/pages/checkout_page.dart';
import 'package:app_movies/pages/detail_checkout.dart';
import 'package:app_movies/pages/home_page.dart';
import 'package:app_movies/pages/insert_admin.dart';
import 'package:app_movies/pages/insert_product.dart';
import 'package:app_movies/pages/login_page.dart';
import 'package:app_movies/pages/main_page.dart';
import 'package:app_movies/pages/cart_tapes.dart';
import 'package:app_movies/pages/payment.dart';
import 'package:app_movies/pages/register_page.dart';
import 'package:app_movies/pages/thankyou_card.dart';
import 'package:app_movies/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      routes: {
        'register': (context) => const RegisterPage(),
        'login': (context) => const LoginPage(),
        'mainPage': (context) => const MainPage(),
        'adminPage': (context) => const AdminPage(),
        'insert': (context) => const InsertProductPage(),
        'home': (context) => const HomePage(),
        'checkout': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;

          Genre genre = _parseGenre(args['genre']!);
          return CheckoutPage(
            title: args['title']!,
            image: args['image']!,
            price: args['price']!,
            description: args['description']!,
            genre: genre,
            level: double.parse(args['level']!),
          );
        },
        'insertAdmin': (context) => const InsertAdmin(),
        'basket': (context) => const BasketPage(),
        'cartTapes': (context) => const CartTapes(
              basket: [],
            ),
        'thankyou': (context) => const ThankyouPage(),
      },
    );
  }

  Genre _parseGenre(String genreString) {
    switch (genreString.toLowerCase()) {
      case 'horror':
        return Genre.horror;
      case 'thriller':
        return Genre.thriller;
      case 'romance':
        return Genre.romance;
      case 'comedy':
        return Genre.comedy;
      case 'family':
        return Genre.family;
      case 'action':
        return Genre.action;
      default:
        return Genre.other;
    }
  }
}
