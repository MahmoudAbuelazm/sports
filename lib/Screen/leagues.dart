import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:sports_app/Data/Cubit/Leagues%20Cubit/leagues_cubit.dart';

import 'package:sports_app/Data/Cubit/teams_cubit/get_teams_cubit.dart';
import 'package:sports_app/Data/Cubit/teams_cubit/get_top_scorer_cubit.dart';
import 'package:sports_app/Data/Rpository/get_topScorer_repo.dart';
import 'package:sports_app/Screen/tabBar_screen.dart';

class LeaguesScreen extends StatefulWidget {
  final String countryId;
  final String countryName;
  final String countryLogo;
  const LeaguesScreen(
      {super.key,
      required this.countryId,
      required this.countryName,
      required this.countryLogo});

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LeaguesCubit>().getAllLeagues(widget.countryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black, // Make the AppBar background transparent
        title: Padding(
          padding: const EdgeInsets.all(70),
          child: Row(
            children: [
              Image.network(
                (widget
                    .countryLogo), // Replace with the path to your Italy image
                height: 30, // Adjust the height as needed
                width: 30, // Adjust the height as needed
              ),
              SizedBox(width: 10),
              Text(
                (widget.countryName).toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            // Define the action you want to perform when the arrow is pressed.
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // vatedButton(
            //     onPressed: () async {
            //       context.read<LeaguesCubit>().getAllLeagues("5");
            //     },
            //     child: Text("Get Updated News")),

            BlocBuilder<LeaguesCubit, LeaguesState>(
              builder: (context, state) {
                if (state is LeaguesInitial) {
                  return Center(
                    child: Text("Please press the button to get news"),
                  );
                } else if (state is LeaguesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LeaguesSuccess) {
                  var leaguesList = state.response.result;
                  return Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: Image.asset(
                          "Images/Background.png",
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: state.response.result.length,
                          // ignore: avoid_types_as_parameter_names
                          itemBuilder: (BuildContext, index) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  league_id =
                                      state.response.result[index].leagueKey;
                                  print(league_id);
                                  context
                                      .read<GetTopScorerCubit>()
                                      .getTopScorer();
                                  context.read<GetTeamsCubit>().getTeams();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              tabBarScreen()));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      13,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,

                                    // borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image(
                                          height: 30,
                                          width: 30,
                                          image: NetworkImage(state.response
                                                  .result[index].leagueLogo ??
                                              'https://as2.ftcdn.net/v2/jpg/04/70/29/87/1000_F_470298738_1eHqTZ0B5AvB3emaESPpvQ93227y7P0l.jpg'),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          (leaguesList[index].leagueName)
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrone"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
