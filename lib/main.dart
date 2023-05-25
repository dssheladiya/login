import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'View/HomeScreen/Image/image_picker.dart';
import 'View/HomeScreen/Image/upload.dart';
import 'View/HomeScreen/Image/upload_image.dart';
import 'View/HomeScreen/Phone/send_otp.dart';
import 'View/HomeScreen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageDemo(),
    );
  }
}
