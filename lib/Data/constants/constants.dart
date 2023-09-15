import 'package:flutter/material.dart';
import 'package:sports_app/Data/Models/onboard_model.dart';




const kBackgroundColor = Color(0xff1e2024);
const kComponentsBackgroundColor = Color(0xff21282d);
const kBlue = Color(0xff15b5e3);

const baseUrl = "https://apiv2.allsportsapi.com";
const apiKey =
    "56c74531e88d4ce2df8cd2a150a449c5425f14eda66bc15b7b8e1c96e8c386e6";

List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    lottieBuilder: 'assets/333.json',
    text: "Welcome to Our Sports Application",
    desc:
        '"Always work hard, never give up, and fight until the end because it’s never really over until the whistle blows."',
    bg: kBackgroundColor,
    button: kComponentsBackgroundColor,
  ),
  OnboardModel(
    lottieBuilder: 'assets/111.json',
    text:
        "In our app , u can find stats about Players From all arround the world",
    desc:
        '"The ability to conquer one’s self is no doubt the most precious of all things that sports bestows"',
    bg: kBackgroundColor,
    button: kBlue,
  ),
  OnboardModel(
    lottieBuilder: 'assets/222.json',
    text: "Hope u enjoy our app :)",
    desc: '"It never gets easier, you just get better."',
    bg: kBackgroundColor,
    button: kBlue,
  ),
];

 
TextEditingController phoneNumberController = TextEditingController();

