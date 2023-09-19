import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/Data/Cubit/Leagues%20Cubit/leagues_cubit.dart';
import 'package:sports_app/Data/Cubit/cubit/cubit/get_players_data_cubit.dart';
import 'package:sports_app/Data/Cubit/cubit/git_country_cubit.dart';
import 'package:sports_app/Data/Cubit/teams_cubit/get_teams_cubit.dart';
import 'package:sports_app/Data/Cubit/teams_cubit/get_top_scorer_cubit.dart';
import 'package:sports_app/Screen/home_screen.dart';
import 'package:sports_app/Screen/onboarding_screen.dart';
import 'package:sports_app/Screen/splashscreen.dart';
import 'package:sports_app/Services/cache_helper.dart';
import 'package:sports_app/Services/fcm.dart';

import 'Screen/country_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService().showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetPlayersDataCubit>(
            create: (BuildContext context) =>
                GetPlayersDataCubit()..gitPlayers()),
        BlocProvider<GitCountryCubit>(
          create: (BuildContext context) => GitCountryCubit(),
        ),
        BlocProvider<LeaguesCubit>(
          create: (BuildContext context) => LeaguesCubit(),
        ),
        BlocProvider<GetTeamsCubit>(
          create: (BuildContext context) => GetTeamsCubit(),
        ),
        BlocProvider<GetTopScorerCubit>(
          create: (BuildContext context) => GetTopScorerCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
