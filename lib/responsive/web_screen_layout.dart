import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  String username = "";

  // initialise the properties of this class
  // can't put async so we need to create another method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    // setState to initialise the properties
    setState(() {
      username = (snapshot.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(username)),
    );
  }
}
