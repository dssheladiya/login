import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userid}) : super(key: key);
  final String userid;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DocumentReference? login;

  GoogleSignIn googleSignIn = GoogleSignIn();
  final box = GetStorage();

  @override
  void initState() {
    login = FirebaseFirestore.instance.collection('login').doc(widget.userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 60),
              Center(
                child: FutureBuilder(
                  future: login!.get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.data;
                      TextEditingController firstNamecontroller =
                          TextEditingController(text: data!['FirstName']);
                      TextEditingController lastNamecontroller =
                          TextEditingController(text: data!['LastName']);
                      TextEditingController emailcontroller =
                          TextEditingController(text: data!['Email']);
                      TextEditingController passwcontroller =
                          TextEditingController(text: data!['password']);
                      return Column(
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey),
                              child: Image.network('${data['imagess']}')),
                          Text('${data['FirstName']}'),
                          Text('${data['LastName']}'),
                          Text('${data['Email']}'),
                          Text('${data['password']}'),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Container(
                                    height: 350,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        TextField(
                                          controller: firstNamecontroller,
                                          decoration: InputDecoration(
                                              labelText: "Firstname",
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none)),
                                        ),
                                        SizedBox(height: 15),
                                        TextField(
                                          controller: lastNamecontroller,
                                          decoration: InputDecoration(
                                              labelText: "Lastname",
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black))),
                                        ),
                                        SizedBox(height: 15),
                                        ElevatedButton(
                                          child: Text('update'),
                                          onPressed: () {
                                            login?.update({
                                              'FirstName':
                                                  firstNamecontroller.text,
                                              'LastName':
                                                  lastNamecontroller.text,
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text('Edit'),
                          ),
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  TextButton(
                    onPressed: () async {
                      await googleSignIn.signOut();
                      await box.erase();
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
                      'LOGOUT',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
