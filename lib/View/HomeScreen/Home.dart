import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:login/View/HomeScreen/login.dart';
import 'package:lottie/lottie.dart';

class HomeDemo extends StatefulWidget {
  const HomeDemo({Key? key}) : super(key: key);
  @override
  State<HomeDemo> createState() => _HomeDemoState();
}

class _HomeDemoState extends State<HomeDemo> {
  @override
  void initState() {
    Timer timer = Timer(
      Duration(seconds: 7),
      () => Get.to(LoginScreen()),
    );
    super.initState();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Center(
              child: Lottie.network(
                  "https://assets2.lottiefiles.com/packages/lf20_AMBEWz.json"),
            ),
          ],
        ),
      ),
    );
  }
}
