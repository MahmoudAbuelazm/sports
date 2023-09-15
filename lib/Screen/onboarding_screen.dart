// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sports_app/Data/constants/constants.dart';
import 'package:sports_app/Screen/login_screen%20.dart';
import 'package:sports_app/Services/cache_helper.dart';
import 'package:sports_app/widget/custom_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < 2) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }

      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('Images/Background.png'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index % screens.length;
                      });
                    },
                    itemBuilder: (_, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset(
                              screens[index % screens.length].lottieBuilder,
                              width: width * 0.8,
                              height: height * 0.4),
                          Text(
                            screens[index % screens.length].text,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.allerta(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            screens[index % screens.length].desc,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.allerta(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              const Spacer(
                flex: 1,
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: screens.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              CustomButton(onTap: () async {
                await CacheHelper.saveData(key: 'onBoarding', value: true);

                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              })
            ],
          ),
        ),
      ),
    );
  }
}
