import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase/authenticate.dart';
import 'package:firebase_database/ui/login_screen.dart';
import 'package:firebase_database/ui/sign_up_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authenticate(),
    );
  }
}
