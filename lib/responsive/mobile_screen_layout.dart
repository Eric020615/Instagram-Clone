import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/providers/user_provider.dart';
import 'package:whatsapp_clone/models/user.dart' as models;
import 'package:whatsapp_clone/utils/colors.dart';
import 'package:whatsapp_clone/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  String username = "";
  late PageController pageController;

  @override
  // run at the start at the application
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void getUsername() async {
    // Create a path to the user collection in the firebase based on the user current uid
    // document reference == DocumentSnapshot (one time view) (like camera take a snapshot)
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    // snapshot.data() == document of the user
    // setState() to user name
    setState(() {
      // specific the snapshot data from object to Json (Map<String, dynamic>)
      // access username like accessing usual json
      username = (snapshot.data() as Map<String, dynamic>)['username'];
    });
  }

  // When page change, bottom bar change
  void navigationTap(int page){
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // models.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        // scroll physics (can't drag and change page)
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              // if page == 0 
              icon: Icon(Icons.home, color: _page == 0 ? primaryColor:secondaryColor),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: _page == 1 ? primaryColor:secondaryColor),
              label: '',
              backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, color: _page == 2 ? primaryColor:secondaryColor),
              label: '',
              backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: _page == 3 ? primaryColor:secondaryColor),
              label: '',
              backgroundColor: primaryColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: _page == 4 ? primaryColor:secondaryColor),
              label: '',
              backgroundColor: primaryColor
          ), 
        ],
        // call back function no parenthesis
        onTap: navigationTap,
      ),
    );
  }
}
