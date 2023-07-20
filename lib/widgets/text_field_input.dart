import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  // the type of input
  final TextInputType textInputType;
  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      // initially set isPass to false even user did not pass the argument for this part 
      this.isPass = false,
      required this.hintText,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    // inside this we need to write the properties of text field
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          // paddingAll 8
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      // if it is password input will be .....
      obscureText: isPass,
    );
  }
}
