import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/utils/colors.dart';
import 'package:whatsapp_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email_controller.dispose();
    _password_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          // we use container since we need the padding
          child: Container(
          // Set the symmetric padding in horizontal with 32
          padding: const EdgeInsets.symmetric(horizontal: 32),
          // expand to full device
          width: double.infinity,
          // Column arrangement
          child: Column(
              // cross axis is horizontally axis
              // make it center
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // add a container at top to make the margin
                Flexible(
                  flex: 2,
                  child: Container()
                ),
                // svg image
                SvgPicture.asset(
                  "assests/ic_instagram.svg",
                  color: primaryColor,
                  height: 64,
                ),
                // make the empty space
                const SizedBox(height: 64),
                // text field input for email
                TextFieldInput(
                  hintText: "Enter your email",
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _email_controller,
                ),
                const SizedBox(
                  height: 24,
                ),
                // text field input for password
                TextFieldInput(
                  textEditingController: _password_controller,
                  hintText: "Enter your password",
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                // button
                InkWell(
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
                    child: const Text("Log in"),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  flex: 2,
                  child: Container()
                ),
                // button login
                // Transitioning to signingup
                // row arrangment widget
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Don't have an account?"),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Sign up.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        )),
    );
  }
}
