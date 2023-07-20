import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods{
  // Create firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Create firebase database instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Sign up user 
  // Future == async method
  // since all firebase method need asynchronous
  Future<String> SignUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    // For the file input (profile picture)
    // required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try{
      // user validation in client side
      if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty){
        // register user
        // we need to await it to collect the value (pause it for a while)
        UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        // put exclamation mark (!) since user can be null it is user?
        // we need to access uid here
        // since it is future type we need to await it
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'username': username,
          'uid': credential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
        });
        res = "success";
      }
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }
}