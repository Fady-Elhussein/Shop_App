
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class photo extends StatefulWidget {
  @override
  _photoState createState() => _photoState();
}

class _photoState extends State<photo> {
  final _picker = ImagePicker();
  PickedFile? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 50,
          backgroundImage: _image != null
              ? FileImage(File(_image!.path))
              : null,
          child: _image == null
              ? IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: _pickImage,
          )
              : null,
        ),
      ),
    );
  }
}
