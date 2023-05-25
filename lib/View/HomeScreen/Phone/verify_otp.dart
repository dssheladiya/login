import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pinput/pinput.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp(
      {Key? key,
      required this.id,
      this.toKen,
      this.phone,
      required this.resendigtoken})
      : super(key: key);
  final id;
  final toKen;
  final phone;
  final int resendigtoken;
  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController otp = TextEditingController();

  int second = 30;
  bool isResend = false;
  String? otpcode;

  void Timerdemo() {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});

      second--;
      if (second == 0) {
        timer.cancel();
        setState(() {
          second = 60;
          isResend = true;
        });
      }
    });
  }

  @override
  void initState() {
    Timerdemo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 400),
                child: InkResponse(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, size: 30)),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'Varification',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Center(
                  child: Text(
                'Enter tha send to tha number',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              )),
              SizedBox(height: 20),
              Center(
                child: Text(
                  '${widget.phone}',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Pinput(
                  length: 6,
                  controller: otp,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      otpcode = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: Colors.blue.withOpacity(0.5),
                  //   padding: EdgeInsets.symmetric(),
                  // ),
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: widget.id, smsCode: otp.text);
                      UserCredential userCredential =
                          await auth.signInWithCredential(credential);
                      print('${userCredential.user!.phoneNumber}');
                      print('${userCredential.user!.uid}');
                    } on FirebaseException catch (e) {
                      print('${e.code}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${e.message}'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Verify',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                  child: Text(
                '${second}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              )),
              SizedBox(height: 20),
              isResend
                  ? Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            auth.verifyPhoneNumber(
                              phoneNumber: "+91 ${widget.phone}",
                              verificationCompleted: (phoneAuthCredential) {
                                log("verifyed");
                              },
                              verificationFailed: (error) {
                                log("ERROR");
                              },
                              codeSent: (verificationId, forceResendingToken) {
                                setState(() {
                                  Get.to(VerifyOtp(
                                      id: verificationId,
                                      phone: otp.text,
                                      resendigtoken: 4,
                                      toKen: forceResendingToken));
                                });
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {
                                log("Time out");
                              },
                              forceResendingToken: widget.toKen,
                            );
                            setState(() {});
                            isResend = false;
                            Timerdemo();
                          },
                          child: Text('resend otp')),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
