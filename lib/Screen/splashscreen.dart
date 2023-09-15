import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_app/Screen/login_screen%20.dart';
import 'package:sports_app/Screen/onboarding_screen.dart';
import 'package:sports_app/Services/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeTextController;
  @override
  void initState() {
    super.initState();
    _fadeTextController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeTextController.forward();

    Timer(const Duration(seconds: 2), () {
      bool isSkiped = CacheHelper.getData(key: 'onBoarding') ?? false;
      if (isSkiped == false) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
      } else {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Images/Background.png"),
                    fit: BoxFit.cover)),
            child: FadeTransition(
              opacity: _fadeTextController,
              child: Center(
                  child: Center(
                child: Text(
                  "Sports",
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Allerta", fontSize: 50),
                ),
              )),
            )));
  }
}
