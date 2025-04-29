import 'dart:convert';
import 'dart:io';

import 'package:app_movies/models/admin.dart';
import 'package:app_movies/models/purchase.dart';
import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/pages/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String URLPATH = "http://127.0.0.1:4000";

Future<List<Tape>> fetchTape({Genre? genre}) async {
  final List<Tape> tapeList = [];

  String url = genre != null
      ? "$URLPATH/tapes?genre=${genre.toString().split('.').last}"
      : "$URLPATH/tapes"; // or "$URLPATH/tapes" if that's your endpoint
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var result = jsonDecode(response.body);

    for (var i in result) {
      print("Genre: ${i['genre']}");
      Tape tape = Tape.fromJson(i);
      tapeList.add(tape);
    }
  } else {
    throw Exception("Failed to load tapes");
  }

  return tapeList;
}

Future<List<Tape>> fetchUpdatedTapes() async {
  return await fetchTape(); // Memanggil fungsi fetchTape yang sudah ada
}

Future<bool> insertTape(String tapeTitle, String description, String tapePrice,
    File? tapeImage, Genre genre, double level, context) async {
  // http.MultiPartFormRequest
  String url = "$URLPATH/tapes";
  var request = http.MultipartRequest("POST", Uri.parse(url));
  request.files
      .add(await http.MultipartFile.fromPath("TapeImage", tapeImage!.path));
  request.fields["TapeTitle"] = tapeTitle;
  request.fields["description"] = description;
  request.fields["TapePrice"] = tapePrice;
  request.fields["TapeGenre"] = genre.name;
  request.fields["level"] = level.toString();

  var result = await request.send();

  if (result.statusCode == 200) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return const AdminPage();
      },
    ), (route) => false);
    return true;
  }
  return false;
}

Future<bool> deleteTape(int id) async {
  String url = "$URLPATH/tapes/$id";

  try {
    var response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to delete tape: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

Future<bool> insertAdmin(
    String username, String password, String role, context) async {
  // http.MultiPartFormRequest
  String url = "$URLPATH/admin/insert";
  try {
    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'admin_name': username,
        'admin_password': password,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminPage(),
          ),
          (route) => false);
      return true;
    } else {
      print('Failed to insert admin: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

Future<User?> tryLogin(String username, String password) async {
  String url = '$URLPATH/users/login';
  var result = await http
      .post(Uri.parse(url), body: {'username': username, 'password': password});

  if (result.statusCode == 200) {
    //return user
    var data = jsonDecode(result.body);
    return User.fromJson(data);
  }
  return null;
}

Future<String?> accessSecretLlink(String token) async {
  String url = '$URLPATH/users/secretLink';
  var result = await http.get(Uri.parse(url), headers: {
    'token': token,
  });

  if (result.statusCode == 200) {
    //return user
    return result.body;
  }

  return null;
}

// Future<void> submitPurchase(List<Purchase> purchases) async {
//   final url = Uri.parse('$URLPATH/tapes/purchases');
//   final body = {
//     'items': purchases.map((purchase) => purchase.toJson()).toList(),
//   };

//   final response = await http.post(
//     url,
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(body),
//   );

//   if (response.statusCode != 200) {
//     throw Exception('Failed to complete purchase: ${response.body}');
//   }
// }
