import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_app/Data/constants/constants.dart';
import 'package:sports_app/Screen/home_screen.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> signOut() async {
  await _googleSignIn.signOut();
  print('sign out');
}

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  String phoneNumber = "";
  String otp = "";
  String generatedOtp = "";
  String errorMessage = "";
  final RegExp numericRegExp = RegExp(r'^[0-9]+$');

  void generateOTP() {
    // Generate a random 4-digit OTP
    final random = Random();
    generatedOtp = (1000 + random.nextInt(9000)).toString();
    // Show OTP in an AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Generated OTP"),
          content: Text(generatedOtp),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void verifyOTP() {
    if (_formKey.currentState!.validate()) {
      if (otp == generatedOtp) {
        // Navigate to the home screen with login data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              name: phoneNumberController.text,
            ),
          ),
        );
      } else {
        // Show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Incorrect OTP. Please try again."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Images/photo_2023-09-02_01-31-07.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Lottie.asset(
                    "assets/animation_lm41di2i.json",
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: phoneNumberController,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  onChanged: (value) {
                                    phoneNumber = value;
                                  },
                                  validator: (value) {
                                    if (!numericRegExp.hasMatch(value!)) {
                                      return "Phone number should contain only numbers";
                                    } else if (value == null || value.isEmpty) {
                                      return "Phone number is required";
                                    } else if (value.length != 11)
                                      return "Phone number is not valid";

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Number",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  onChanged: (value) {
                                    otp = value;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "OTP",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "OTP is required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await signInWithGoogle().then((value) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                          name: phoneNumberController.text,
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                  child: Image.asset(
                                    'Images/google-icon-1024x1024-hv1t7wtt.png',
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: generateOTP,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              GestureDetector(
                                onTap: verifyOTP,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      print(user!.displayName);
      print(user.email);
      print(user.photoURL);
      print(user.phoneNumber);
      print(user.uid);

      phoneNumberController.text = user.displayName!;
    } catch (e) {
      print(e);
    }
  }
}
