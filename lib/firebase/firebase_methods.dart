import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<User?> createAccount(
    String firstName, String lastName, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Account created Successfully");

      user.updateProfile(displayName: firstName);

      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "first name": firstName,
        "last name": lastName,
        "email": email,
        "uid": _auth.currentUser!.uid,
      });

      return user;
    } else {
      print("Account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Login Sucessfull");
      _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) => user.updateProfile(displayName: value['name']));

      return user;
    } else {
      print("Login Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}

/*
Future<List> getUserList(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List userList = [];
  DocumentSnapshot? documentSnapshot =
      await _firestore.collection('users').doc(auth.currentUser!.uid).get();
  userList = documentSnapshot.data()['userList'];

  return userList;
}
*/

