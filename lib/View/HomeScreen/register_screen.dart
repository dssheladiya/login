import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'home_screen.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var login = FirebaseFirestore.instance.collection('login');
  // var logins = FirebaseFirestore.instance
  //     .collection("login")
  //     .doc("CcADL1fQrm9kLmjits9S");
  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController lastNamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwcontroller = TextEditingController();

  int groupvalue = 0;
  bool loading = false;
  bool hidepassword = false;
  final box = GetStorage();

  var formkey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference logins = FirebaseFirestore.instance.collection('login');
  FirebaseStorage storage = FirebaseStorage.instance;
  ImagePicker picker = ImagePicker();
  File? image;
  String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Container(
                    height: 230,
                    width: 450,
                    child: Center(
                      child: Lottie.network(
                          "https://assets6.lottiefiles.com/packages/lf20_vwCDpL.json"),
                    ),
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: InkResponse(
                      onTap: () async {
                        XFile? file = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 10);
                        image = File(file!.path);
                        setState(() {});
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey),
                        child: image == null
                            ? Center(child: Icon(Icons.image))
                            : Image.file(image!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: firstNamecontroller,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        hintText: "First Name",
                        labelText: "First Name",
                        fillColor: Colors.purple.shade100,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Place Enter First Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: lastNamecontroller,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_outlined),
                        hintText: "Last Name",
                        labelText: "Last Name",
                        fillColor: Colors.purple.shade100,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Place Enter Last Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: "Email",
                        labelText: "Email",
                        fillColor: Colors.purple.shade100,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Place Enter Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidepassword = !hidepassword;
                            });
                          },
                          icon: hidepassword == true
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        hintText: "password",
                        labelText: "password",
                        fillColor: Colors.purple.shade100,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Place Enter Password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 30),
                      Text("Male"),
                      Radio(
                          value: 1,
                          groupValue: groupvalue,
                          onChanged: (int? value) {
                            setState(() {});
                            groupvalue = value!;
                          }),
                      SizedBox(width: 10),
                      Text("Female"),
                      Radio(
                          value: 2,
                          groupValue: groupvalue,
                          onChanged: (int? value) {
                            setState(() {});
                            groupvalue = value!;
                          }),
                      SizedBox(width: 10),
                      Text("Other"),
                      Radio(
                          value: 3,
                          groupValue: groupvalue,
                          onChanged: (int? value) {
                            setState(() {});
                            groupvalue = value!;
                          }),
                    ],
                  ),
                  SizedBox(height: 10),
                  loading
                      ? const CircularProgressIndicator()
                      : Center(
                          child: ElevatedButton(
                            child: const Text('Sign in'),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              try {
                                UserCredential credential =
                                    await auth.createUserWithEmailAndPassword(
                                        email: emailcontroller.text,
                                        password: passwcontroller.text);

                                print('${credential.user!.email}');
                                print('${credential.user!.uid}');

                                await box.write('userid', credential.user!.uid);
                                setState(() {
                                  loading = false;
                                });
                                await storage
                                    .ref('profile/')
                                    .putFile(image!)
                                    .then((p0) async {
                                  url = await p0.ref.getDownloadURL();
                                  print('url $url');
                                });

                                login.doc(credential.user!.uid).set(
                                  {
                                    "FirstName": firstNamecontroller.text,
                                    "LastName": lastNamecontroller.text,
                                    "Email": emailcontroller.text,
                                    "password": passwcontroller.text,
                                    "imagess": url,
                                  },
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                          userid: credential.user!.uid),
                                    ));
                              } on FirebaseAuthException catch (e) {
                                print('${e.code}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${e.message}'),
                                  ),
                                );
                                setState(() {
                                  loading = false;
                                });
                              }
                            },
                          ),
                        ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Already have an account ?"),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          });
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.red,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
