import 'package:flutter/material.dart';

void toast(String text, context) {
  var snackBar = SnackBar(
    content: Text(text),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
