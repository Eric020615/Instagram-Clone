import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/user.dart';
import 'package:whatsapp_clone/resources/auth_methods.dart';

// extends the superclass changeNotifier
class UserProvider with ChangeNotifier{
  // underscore to make this variable private field
  User? _user; 
  // create an instance of class
  final AuthMethods _authMethods = AuthMethods();

  // Accessor method 
  // return User object
  User get getUser => _user!;

  Future<void> refreshUser() async{
    // return the user model
    User user = await _authMethods.getUserDetails();
    _user = user;
    // notify all the data if there is change on data
    notifyListeners();
  }
}