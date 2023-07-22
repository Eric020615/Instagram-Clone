import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String username;
  final String uid;
  final String email;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;

  // constructor
  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  // Json function in document format since firebase require this
  // Json format == Map<String, Dynamic>
  // Function to return Json document
  Map<String, dynamic> toJson() =>{
    "username": username,
    "uid": uid,
    "email": email,
    "bio": bio,
    "followers": followers,
    "following": following,
    "photoUrl": photoUrl,    
  };

  // function to get the document from firebase
  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      photoUrl: snapshot['photoUrl'], 
    );
  }
}