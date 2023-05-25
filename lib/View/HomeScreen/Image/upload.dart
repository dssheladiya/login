import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadDemo extends StatefulWidget {
  const UploadDemo({Key? key}) : super(key: key);

  @override
  State<UploadDemo> createState() => _UploadDemoState();
}

class _UploadDemoState extends State<UploadDemo> {
  ImagePicker picker = ImagePicker();

  FirebaseStorage storage = FirebaseStorage.instance;

  File? image;
  List allimage = [];
  CollectionReference Uploadd1 =
      FirebaseFirestore.instance.collection("Uploadd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: allimage.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    width: 200,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: allimage == []
                        ? SizedBox()
                        : Image.file(allimage[index]!, fit: BoxFit.cover),
                  );
                },
              ),
            ),
            InkResponse(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkResponse(
                              onTap: () async {
                                XFile? file = await picker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 10);
                                allimage.add(File(file!.path));
                                setState(() {});
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.camera, size: 50),
                              ),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () async {
                                XFile? file = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 10);
                                allimage.add(File(file!.path));
                                setState(() {});
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.image, size: 50),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                height: 60,
                width: 100,
                color: Colors.grey,
                child: Center(child: Text("Select image")),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                for (var i = 0; i < allimage.length; i++) {
                  storage
                      .ref('Profile/image$i')
                      .putFile(allimage[i])
                      .then((p0) async {
                    String url = await p0.ref.getDownloadURL();

                    log('URL $url');
                    Uploadd1.add({"uploa": "${url}"});
                  });
                }
                setState(() {});
              },
              child: Text("upload"),
            ),
          ],
        ),
      ),
    );
  }
}
