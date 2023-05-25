import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageDemo extends StatefulWidget {
  const ImageDemo({Key? key}) : super(key: key);

  @override
  State<ImageDemo> createState() => _ImageDemoState();
}

class _ImageDemoState extends State<ImageDemo> {
  ImagePicker picker = ImagePicker();

  FirebaseStorage storage = FirebaseStorage.instance;

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  XFile? file = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 10);
                  image = File(file!.path);
                  setState(() {});
                },
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: image == null
                      ? const Center(
                          child: Icon(Icons.image, size: 50),
                        )
                      : Image.file(image!, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  storage
                      .ref('profile/user1ProfileImage.png')
                      .putFile(image!)
                      .then(
                    (p0) async {
                      String url = await p0.ref.getDownloadURL();

                      print('URL $url');
                    },
                  );
                },
                child: Text("upload"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
