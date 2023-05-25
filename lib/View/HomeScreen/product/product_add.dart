import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login/View/HomeScreen/product/product_stor.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  TextEditingController productcontroller = TextEditingController();
  TextEditingController mrpcontroller = TextEditingController();
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController discountcontroller = TextEditingController();

  CollectionReference product =
      FirebaseFirestore.instance.collection("product");
  DocumentReference produc = FirebaseFirestore.instance
      .collection("product")
      .doc("XHH34DA07COZ54bvq0Wg");
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductStor(),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Data Enter",
                  style:
                      TextStyle(color: Colors.black, fontSize: height * 0.05),
                ),
                SizedBox(height: height * 0.03),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: productcontroller,
                  decoration: InputDecoration(
                      labelText: "ProductName",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(height * 0.01))),
                ),
                SizedBox(height: height * 0.02),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: mrpcontroller,
                  decoration: InputDecoration(
                      labelText: "Mrp",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(height * 0.01))),
                ),
                SizedBox(height: height * 0.02),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: weightcontroller,
                  decoration: InputDecoration(
                      labelText: "Weight",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(height * 0.01))),
                ),
                SizedBox(height: height * 0.02),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: discountcontroller,
                  decoration: InputDecoration(
                      labelText: "discount",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(height * 0.01))),
                ),
                SizedBox(height: 20),
                loading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          product.add({
                            "Product": productcontroller.text,
                            "Mrp": mrpcontroller.text,
                            "Weight": weightcontroller.text,
                            "Discount": discountcontroller.text,
                          });
                          productcontroller.clear();
                          mrpcontroller.clear();
                          weightcontroller.clear();
                          discountcontroller.clear();
                          setState(() {
                            loading = false;
                          });
                        },
                        child: Text("Add"),
                      ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      produc.update({
                        "Product": productcontroller.text,
                        "Mrp": mrpcontroller.text,
                        "Weight": weightcontroller.text,
                        "Discount": discountcontroller.text,
                      });
                    },
                    child: Text("update")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
