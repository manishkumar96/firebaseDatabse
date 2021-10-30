import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase/firebase_methods.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs.map((doc) {
                  return ListTile(
                    title: Text(doc.data()['first name']['last name']),
                    subtitle: Text(doc.data()['email']),
                  );
                }).toList());
            }
          },
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      leading: GestureDetector(
          onTap: () {
            userLogout();
          },
          child: const Icon(Icons.exit_to_app)),
    );
  }

  void userLogout() {
    logOut(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: const Text("User logout success")));
  }

  getUserList(AsyncSnapshot<Object?> snapshot) {}
}
