import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/View/HomeScreen/Phone/verify_otp.dart';

class SendOtp extends StatefulWidget {
  const SendOtp({Key? key}) : super(key: key);

  @override
  State<SendOtp> createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var formkey = GlobalKey<FormState>();
  TextEditingController number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.call, color: Colors.red),
                        hintText: 'Number...',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.10),
                                width: 1))),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text("Send"),
                    onPressed: () async {
                      try {
                        auth.verifyPhoneNumber(
                          phoneNumber: "+91 ${number.text}",
                          verificationCompleted: (phoneAuthCredential) {
                            log("verified");
                          },
                          verificationFailed: (error) {
                            log("ERROR");
                          },
                          codeSent: (verificationId, forceResendingToken) {
                            Get.to(
                              VerifyOtp(
                                  resendigtoken: 4,
                                  id: verificationId,
                                  phone: number.text,
                                  toKen: forceResendingToken),
                            );
                          },
                          codeAutoRetrievalTimeout: (verificationId) {
                            log('TIME OUT');
                          },
                        );
                      } on FirebaseException catch (e) {
                        print('${e.code}');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("${e.message}"),
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
