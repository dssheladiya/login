import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDemo extends StatefulWidget {
  const ProductDemo({Key? key, this.product}) : super(key: key);
  final product;
  @override
  State<ProductDemo> createState() => _ProductDemoState();
}

class _ProductDemoState extends State<ProductDemo> {
  DocumentReference? productDetails;

  @override
  void initState() {
    productDetails =
        FirebaseFirestore.instance.collection("product").doc(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: productDetails?.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var dataStore = snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Text('product Discount :${dataStore!["Discount"]}'),
                      SizedBox(height: 10),
                      Text('product Mrp :${dataStore!["Mrp"]}'),
                      SizedBox(height: 10),
                      Text('product Product :${dataStore!["Product"]}'),
                      SizedBox(height: 10),
                      Text('product Weight :${dataStore!["Weight"]}'),
                      SizedBox(height: 10),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
