import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/Constant/text_style.dart';

Widget commonButton(
  String title,
  Function() onTap,
  double height,
  double width,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.brown),
      child: Center(
        child: Text(title, style: Kblue25w500),
      ),
    ),
  );
}
