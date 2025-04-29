import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void signInGoogle(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
// Performs Sign In, will return user account's info
  final GoogleSignInAccount? account = await googleSignIn.signIn();
// Account will be null if user cancelled the sign in process
  if (account != null) {
    print('Email user: ${account.email}');
    print('Nama user: ${account.displayName}');

    Navigator.pushNamed(context, 'home');
  }
}

void signOutGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  if (await googleSignIn.isSignedIn()) {
    await googleSignIn.signOut();
  }
}
