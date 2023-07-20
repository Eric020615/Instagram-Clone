import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/utils/colors.dart';
import 'package:whatsapp_clone/utils/utils.dart';
import 'package:whatsapp_clone/widgets/text_field_input.dart';
import 'package:whatsapp_clone/resources/auth_methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  final TextEditingController _bio_controller = TextEditingController();
  final TextEditingController _username_controller = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email_controller.dispose();
    _password_controller.dispose();
    _bio_controller.dispose();
    _username_controller.dispose();
  }

  void selectImage() async {
    // dynamic image can be Uint8List
    // but Uint8List cannot be dynamic image
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      // _image == global variable
      _image = image;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                // occupied how many spaces
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                "assests/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 24,
              ),
              Stack(
                children: [
                  _image!=null? 
                    CircleAvatar(
                      radius: 64,
                      // MemoryImage can access Uint8List image type
                      // use ! since it must be not null
                      backgroundImage: MemoryImage(_image!),
                    ):const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfZCGFDrC8YeednlJC3mhxPfg_s4Pg8u7-kf6dy88&s"
                      ),
                    ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,

                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              // TextFieldInput for username
              TextFieldInput(
                textEditingController: _username_controller, 
                hintText: "Please enter your username", 
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _email_controller, 
                hintText: "Please enter email address", 
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _password_controller, 
                hintText: "Please enter your password", 
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
               TextFieldInput(
                textEditingController: _bio_controller, 
                hintText: "Please enter your bio", 
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              // rectangular area responds to touch
              InkWell(
                // cannot use arrow function since it is asynchronous function
                onTap: () async {
                  AuthMethods().SignUpUser(
                    email: _email_controller.text, 
                    password: _password_controller.text, 
                    username: _username_controller.text, 
                    bio: _bio_controller.text, 
                    
                  );
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4)
                      )
                    ),
                    color: blueColor
                  ),
                  child: const Text("Sign Up"),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container()
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have account?"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Log In.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
