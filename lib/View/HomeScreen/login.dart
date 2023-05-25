import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/View/HomeScreen/Widgets/common_button.dart';
import 'package:login/View/HomeScreen/home_screen.dart';
import 'package:lottie/lottie.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final box = GetStorage();
  var formkey = GlobalKey<FormState>();
  bool loading = false;
  bool hidepassword = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwcontroller = TextEditingController();

  FirebaseAuth auth1 = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Welcome Back",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Make it work, make it right,make it fast",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailcontroller,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline,
                      ),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Place Enter User Name';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: hidepassword,
                    controller: passwcontroller,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidepassword = !hidepassword;
                          });
                        },
                        icon: hidepassword == true
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Place Enter Password';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 230),
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                          color: Colors.blue,
                          //fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 10),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : commonButton("LOGIN", () async {
                          setState(() {
                            loading = true;
                          });

                          try {
                            UserCredential credential =
                                await auth.signInWithEmailAndPassword(
                                    email: emailcontroller.text,
                                    password: passwcontroller.text);

                            print('${credential.user!.email}');
                            print('${credential.user!.uid}');
                            await box.write("userid", credential.user!.uid);
                            setState(() {
                              loading = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(userid: credential.user!.uid),
                                ));
                          } on FirebaseAuthException catch (e) {
                            print("${e.code}");
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${e.message}")));
                            setState(() {
                              loading = false;
                            });
                          }
                        }, 60, 300),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 160),
                    child: Text(
                      "OR",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkResponse(
                    onTap: () async {
                      GoogleSignInAccount? account =
                          await googleSignIn.signIn();
                      GoogleSignInAuthentication authentication =
                          await account!.authentication;
                      OAuthCredential credential =
                          GoogleAuthProvider.credential(
                              accessToken: authentication.accessToken,
                              idToken: authentication.idToken);

                      UserCredential usercredential =
                          await auth1.signInWithCredential(credential);

                      //   print("${usercredential.user!.displayName}");
                      print("${usercredential.user!.uid}");
                      //  print("${usercredential.user!.photoURL}");
                      print("${usercredential.user!.email}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(userid: "CcADL1fQrm9kLmjits9S"),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://w7.pngwing.com/pngs/249/19/png-transparent-google-logo-g-suite-google-guava-google-plus-company-text-logo.png"),
                                    scale: 5)),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Sign-In with Google",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have on account?",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 10),
                      InkResponse(
                        onTap: () {
                          Get.to(RegisterScreen());
                        },
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
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
