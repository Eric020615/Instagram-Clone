import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
pickImage(ImageSource source) async {
  // create instance of ImagePicker class
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if(_file != null){
    // since we need access the value returned by the future function
    // we need to put await to wait for the process done
    // we cannot use this dart io file input output method since it is a web app
    // return File(_file.path);
    return await _file.readAsBytes();
  }
  print('No image selected');
}

// Like toast message
showSnackBar(String content, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content)
    )
  );
}