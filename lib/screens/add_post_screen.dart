import 'dart:js_interop';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/providers/user_provider.dart';
import 'package:whatsapp_clone/utils/colors.dart';
import 'package:whatsapp_clone/utils/utils.dart';
import 'package:whatsapp_clone/models/user.dart' as model;

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;

  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text('Create a post'),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('Take a photo'),
            onPressed: () async {
              // pop this context from stack means remove this context
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            // 
            padding: const EdgeInsets.all(20),
            child: const Text('Select from photo gallery'),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                _file = file;
              });
            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
    ? Center(
      child: IconButton(
        icon: const Icon(Icons.upload),
        // if button clicked run the function _selectImage
        onPressed: () => _selectImage(context),
      ),
    ): Scaffold(
      // Action bar
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading:
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
        title: const Text('Post To'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),
        ],
      ),
      body: Column(
        children: [
          Row(
            // horizontal since row is in horizontal so main axis will be horizontal
            // if column it is vertical so main axis will be vertical
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // vertically
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.photoUrl,
                ),
              ),
              SizedBox(
                // 0.3 constraint value
                width: MediaQuery.of(context).size.width * 0.45,
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Write a caption...',
                    border: InputBorder.none,
                  ),
                  // maximum length of character of the text inputr field 8
                  maxLength: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487/451,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(                  
                          "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1171&q=80"
                        ),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],

          )
        ],
      ),
    );
  }
}
