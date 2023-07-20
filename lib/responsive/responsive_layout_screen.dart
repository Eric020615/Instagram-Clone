import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/dimension.dart';

// ResponsiveLayout is the subclass of StatelessWidget
class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  // Invoke the constructor and key: key mean we initialise the key value here to the key variable in constructor
  const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // this help us to build responsive layout
    return LayoutBuilder(
      builder: (context, constraints){
        // if the width more than webScreenSize (600) display web layout
        if(constraints.maxWidth > webScreenSize){
          // web screen
          return webScreenLayout;
        }
        // mobile screen
        return mobileScreenLayout;
      },
    );
  }
}