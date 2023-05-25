import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/View/HomeScreen/product/product_detalis.dart';

class ProductStor extends StatefulWidget {
  const ProductStor({Key? key}) : super(key: key);

  @override
  State<ProductStor> createState() => _ProductStorState();
}

class _ProductStorState extends State<ProductStor> {
  CollectionReference product =
      FirebaseFirestore.instance.collection("product");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: product.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var dataStore =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return InkResponse(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDemo(
                                product: snapshot.data!.docs[index].id),
                          ));
                    },
                    child: Column(
                      children: [
                        ListTile(
                            leading: Text("Product  : "),
                            title: Text('${dataStore["Product"]}')),
                        SizedBox(height: 10),
                        ListTile(
                            leading: Text("Mrp  : "),
                            title: Text('${dataStore["Mrp"]}')),
                        SizedBox(height: 10),
                        ListTile(
                            leading: Text("Weight  : "),
                            title: Text('${dataStore["Weight"]}')),
                        SizedBox(height: 10),
                        ListTile(
                            leading: Text("Discount  : "),
                            title: Text('${dataStore["Discount"]}')),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
