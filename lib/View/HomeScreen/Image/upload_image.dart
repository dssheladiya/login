// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class Demo extends StatefulWidget {
//   const Demo({Key? key}) : super(key: key);
//
//   @override
//   State<Demo> createState() => _DemoState();
// }
//
// class _DemoState extends State<Demo> {
//   CollectionReference profile =
//       FirebaseFirestore.instance.collection("Uploadd");
//
//   ImagePicker picker = ImagePicker();
//   List images = [];
//   FirebaseStorage storage = FirebaseStorage.instance;
//   File? image;
//
//   Future getData() async {
//     var data = await profile.get();
//
//     for (var element in data.docs) {
//       Map data1 = element.data() as Map;
//
//       images.add(data1['profile']);
//       setState(() {});
//     }
//   }
//
//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.photo),
//         onPressed: () async {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Column(
//                   children: [
//                     Text("Choose a Photos"),
//                     SizedBox(height: 10),
//                     ButtonBar(
//                       alignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                             onPressed: () async {
//                               XFile? file = await picker.pickImage(
//                                   source: ImageSource.camera, imageQuality: 10);
//
//                               images.add(File(file!.path));
//                               setState(() {});
//                             },
//                             child: Icon(Icons.camera_alt)),
//                         SizedBox(width: 10),
//                         ElevatedButton(
//                             onPressed: () async {
//                               XFile? file = await picker.pickImage(
//                                   source: ImageSource.gallery,
//                                   imageQuality: 10);
//
//                               images.add(File(file!.path));
//                               setState(() {});
//                             },
//                             child:
//                                 Icon(Icons.photo_size_select_actual_outlined)),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 itemCount: images.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 30),
//                         height: 300,
//                         width: 300,
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 20,
//                                 spreadRadius: 1),
//                           ],
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: images == []
//                             ? SizedBox()
//                             : images[index]!.toString().contains('http')
//                                 ? Image.network(images[index]!,
//                                     fit: BoxFit.cover)
//                                 : Image.file(images[index]!, fit: BoxFit.cover),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 for (var i = 0; i < images.length; i++) {
//                   if (images[i].toString().contains('http')) {
//                   } else {
//                     await storage
//                         .ref('Profile/image${images.length + i}')
//                         .putFile(images[i]!)
//                         .then(
//                       (p0) async {
//                         String url = await p0.ref.getDownloadURL();
//                         profile.add({"photos": "$url"});
//                         print('URL $url');
//                       },
//                     );
//                   }
//                 }
//               },
//               child: Text("upload"),
//             ),
//             IconButton(
//               onPressed: () {
//                 images.clear();
//               },
//               icon: Icon(Icons.refresh_outlined),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DemoImagePick1 extends StatefulWidget {
  const DemoImagePick1({Key? key}) : super(key: key);

  @override
  State<DemoImagePick1> createState() => _DemoImagePick1State();
}

class _DemoImagePick1State extends State<DemoImagePick1> {
  CollectionReference profile = FirebaseFirestore.instance.collection('upload');
  ImagePicker picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;
  File? image;
  List allimage = [];

  Future getData() async {
    var data = await profile.get();

    for (var element in data.docs) {
      Map data1 = element.data() as Map;

      allimage.add(data1['imagess']);
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              XFile? file = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 10);

                              allimage.add(File(file!.path));
                              setState(() {});
                            },
                            child: const Icon(Icons.image),
                          ),
                          const SizedBox(width: 26),
                          ElevatedButton(
                            onPressed: () async {
                              XFile? file = await picker.pickImage(
                                  source: ImageSource.camera, imageQuality: 10);
                              allimage.add(File(file!.path));
                              setState(() {});
                            },
                            child: Icon(Icons.camera_alt),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          });
        },
        child: Icon(Icons.image),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.builder(
                itemCount: allimage.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    width: 80,
                    color: Colors.cyan.shade100,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: allimage.isEmpty || allimage == []
                        ? SizedBox()
                        : allimage[index]!.toString().contains('http')
                            ? Image.network(allimage[index]!, fit: BoxFit.cover)
                            : Image.file(allimage[index]!, fit: BoxFit.cover),
                  );
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  for (int i = 0; i < allimage.length; i++) {
                    if (allimage[i].toString().contains('http')) {
                    } else {
                      await storage
                          .ref('profile/image${allimage.length + i}')
                          .putFile(allimage[i]!)
                          .then(
                        (p0) async {
                          String url = await p0.ref.getDownloadURL();
                          print('URL $url');
                          profile.add({'imagess': '${url}'});
                        },
                      );
                    }
                  }
                },
                child: Text(
                  'Upload',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
