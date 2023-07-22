import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/providers/user_provider.dart';
import 'package:whatsapp_clone/utils/global_variable.dart';

// ResponsiveLayout is the subclass of StatelessWidget
class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  // Invoke the constructor and key: key mean we initialise the key value here to the key variable in constructor
  const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async{
    // context from this layout
    // listen to make it one time view
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    // this help us to build responsive layout
    return LayoutBuilder(
      builder: (context, constraints){
        // if the width more than webScreenSize (600) display web layout
        if(constraints.maxWidth > webScreenSize){
          // web screen
          return widget.webScreenLayout;
        }
        // mobile screen
        return widget.mobileScreenLayout;
      },
    );
  }
}