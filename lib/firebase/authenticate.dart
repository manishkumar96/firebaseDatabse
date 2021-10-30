import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/home_screen.dart';
import 'package:firebase_database/ui/login_screen.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

   Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
