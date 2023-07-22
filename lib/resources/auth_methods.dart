import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/user.dart' as models;
import 'package:whatsapp_clone/resources/storage_method.dart';

class AuthMethods{
  // Create firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Create firebase database instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<models.User> getUserDetails() async{
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    return models.User.fromSnap(snap);
  }

  // Sign up user 
  // Future == async method
  // since all firebase method need asynchronous
  Future<String> SignUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    // For the file input (profile picture)
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try{
      // user validation in client side
      if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty){
        // register user
        // we need to await it to collect the value (pause it for a while)
        UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        // create user model
        models.User user = models.User(
          email: email, 
          uid: credential.user!.uid, 
          photoUrl: photoUrl, 
          username: username, 
          bio: bio, 
          followers: [], 
          following: []
        );
        // put exclamation mark (!) since user can be null it is user?
        // we need to access uid here
        // since it is future type we need to await it
        await _firestore.collection('users').doc(credential.user!.uid).set(user.toJson());
        res = "success";
      }
    }
    on FirebaseAuthException catch(err){
      if(err.code == 'invalid-email'){
        res = 'The email is badly formatted.';
      }
      else if(err.code == 'weak-password'){
        res = 'Password should be at least 6 characters.';
      }
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
      required String email,
      required String password
  }) async {
    String res = "Some error occurred";
    try{
      if(email.isNotEmpty||password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(
          email: email, 
          password: password
        );
        res = "success";
      }
      else{
        res = "Please enter all the fields";
      }
    }
    on FirebaseAuthException catch(err){
      if(err.code == 'user-not-found'){
        res = "User not found";
      }
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }
}