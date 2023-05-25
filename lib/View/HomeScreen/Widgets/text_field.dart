import 'package:flutter/material.dart';

TextField buildTextField() {
  return TextField(
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.add),
      hintText: "Name",
      labelText: "Name",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
