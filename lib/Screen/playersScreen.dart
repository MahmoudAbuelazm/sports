//import 'dart:collection';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sports_app/Data/Cubit/cubit/cubit/get_players_data_cubit.dart';
import 'package:sports_app/Data/Cubit/teams_cubit/get_teams_cubit.dart';
// import 'package:share_plus/share_plus.dart';
//import 'package:sports_app/Data/Cubit/playersCubit/get_players_data_cubit.dart';
//import 'package:sports_app/Global/global_data.dart';
//import 'package:sports_app/Cubits/buttoncubit/cubit/button_cubit_cubit.dart';
//import 'package:sports_app/Data/cubits/fffff/cubit/get_players_data_cubit.dart';
//import 'package:sports_app/Data/model/git_players_data.dart';
//import 'package:sports_app/Data/reposetory/get_players_data_repo.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sports_app/Cubits/Button%20Cubits/cubit/button_cubits_cubit.dart';
// import 'package:sports_app/Screens/Dialog.dart';

class Players extends StatelessWidget {
  final int team;
  Players({super.key, required this.team});

  final TextEditingController searchController = TextEditingController();
  //String? user;
  @override
  Widget build(BuildContext context) {
    // if (phoneNumberController.text.isNotEmpty) {
    //   user = phoneNumberController.text;
    // }
    return BlocBuilder<GetTeamsCubit, GetTeamsState>(
      builder: (context, state) {
        if (state is GetTeamsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetTeamsSuccess) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    color: Colors.white,
                    iconSize: 30,
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    splashColor: Colors.blueGrey,
                    onPressed: () {
                      Scaffold.of(appBarContext).openDrawer();
                    },
                  );
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            drawer: Drawer(
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    DrawerHeader(
                      child: Center(
                        child: Text(
                          "Welcome",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("user"),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                      onTap: () {
                        // Handle logout logic here
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: Center(
              child: Container(
                // height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Images/Background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            //     color: Color(0xff000000),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 130),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 25),
                                    child: Image(
                                        width: 64,
                                        height: 80,
                                        image: NetworkImage(
                                          state.teamsresponse.result[team]
                                                  .teamLogo ??
                                              "https://thumbs.dreamstime.com/b/mo-salah-professional-footballer-vector-image-bandung-indonesia-march-mo-salah-professional-footballer-vector-image-242630646.jpg",
                                        )),
                                  ),
                                  Text(
                                    state.teamsresponse.result[team].teamName ??
                                        "Team",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: "Allerta",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        "SQUAD",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 33,
                          color: Colors.white,
                          fontFamily: "Allerta",
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Divider(
                        color: Colors.white,
                        indent: 110,
                        endIndent: 110,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Allerta",
                              fontSize: 15,
                            ),
                          ),
                          hintText: "Enter Player Name",
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Allerta",
                            fontSize: 15,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 35, 33, 44),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 159, 158, 159),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onSubmitted: (data) {
                          if (data.isNotEmpty) {
                            context
                                .read<GetPlayersDataCubit>()
                                .getSearchPlayers(data);
                          } else {
                            context.read<GetPlayersDataCubit>().gitPlayers();
                          }
                        },
                      ),
                    ),
                    BlocBuilder<GetTeamsCubit, GetTeamsState>(
                      builder: (context, state) {
                        if (state is GetTeamsSuccess) {





























                          
                          return Expanded(
                            child: ListView.builder(
                              itemCount: state
                                  .teamsresponse.result[team].players.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 400,
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return alertDialog(
                                              context, state, index);
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                    ),
                                    child: Container(
                                      height: 67,
                                      width: 375,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0x2BC8C8C8),
                                            Color(0xFF2F0141),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(35.0),
                                              child: CachedNetworkImage(
                                                width: 47,
                                                height: 47,
                                                imageUrl: state
                                                        .teamsresponse
                                                        .result[team]
                                                        .players[index]
                                                        .playerImage ??
                                                    "https://thumbs.dreamstime.com/b/mo-salah-professional-footballer-vector-image-bandung-indonesia-march-mo-salah-professional-footballer-vector-image-242630646.jpg",
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.network(
                                                        "https://thumbs.dreamstime.com/b/mo-salah-professional-footballer-vector-image-bandung-indonesia-march-mo-salah-professional-footballer-vector-image-242630646.jpg"),
                                                placeholder: (context, url) =>
                                                    Image.network(
                                                        "https://thumbs.dreamstime.com/b/mo-salah-professional-footballer-vector-image-bandung-indonesia-march-mo-salah-professional-footballer-vector-image-242630646.jpg"),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 90,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state
                                                            .teamsresponse
                                                            .result[team]
                                                            .players[index]
                                                            .playerName ??
                                                        "MoSalah",
                                                    style: const TextStyle(
                                                      color: Color(0xffFFFFFF),
                                                      fontFamily: "Allerta",
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    state
                                                            .teamsresponse
                                                            .result[team]
                                                            .players[index]
                                                            .playerType ??
                                                        "Coach",
                                                    style: const TextStyle(
                                                      color: Color(0xff999999),
                                                      fontFamily: "Allerta",
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is GetTeamsLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Text('Not Found');
                        }
                        ;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: Text('Error')),
          );
        }
      },
    );
  }

  Widget alertDialog(BuildContext context, GetTeamsSuccess state, int index) {
    return Center(
      child: SizedBox(
        height: 650,
        child: Stack(
          children: [
            SizedBox(
              height: 500,
              child: AlertDialog(
                backgroundColor: const Color(0xff333333),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                content: SizedBox(
                  height: 350,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        state.teamsresponse.result[team].players[index]
                                    .playerName!.isEmpty ||
                                state.teamsresponse.result[team].players[index]
                                        .playerName! ==
                                    ""
                            ? "Mosalah"
                            : state.teamsresponse.result[team].players[index]
                                    .playerName ??
                                "MOSalah",
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                          fontFamily: "Allerta",
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Player Details",
                        style: TextStyle(
                            fontFamily: "Allerta",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xffFFFFFF)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Divider(
                          thickness: 1,
                          color: Color(0xff000000),
                          indent: 0,
                          endIndent: 0,
                        ),
                      ),
                      Text(
                        "From ${state.teamsresponse.result[team].players[index].playerCountry ?? "Egypt"}",
                        style: const TextStyle(
                          fontFamily: "Allerta",
                          fontWeight: FontWeight.w400,
                          fontSize: 23,
                          color: Color(
                            0xffFFFFFF,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                state.teamsresponse.result[team].players[index]
                                                .playerAge ==
                                            null ||
                                        state.teamsresponse.result[team]
                                                .players[index].playerAge ==
                                            ""
                                    ? "31"
                                    : state.teamsresponse.result[team]
                                            .players[index].playerAge ??
                                        '33',
                                style: const TextStyle(
                                    fontFamily: "Tahoma",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              const Text(
                                "Years",
                                style: TextStyle(
                                  fontFamily: "Tahoma",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                state.teamsresponse.result[team].players[index]
                                                .playerGoals ==
                                            null ||
                                        state.teamsresponse.result[team]
                                                .players[index].playerGoals ==
                                            ""
                                    ? "32"
                                    : state.teamsresponse.result[team]
                                            .players[index].playerGoals ??
                                        "30",
                                style: const TextStyle(
                                    fontFamily: "Tahoma",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              const Text(
                                " Goals",
                                style: TextStyle(
                                  fontFamily: "Tahoma",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                state.teamsresponse.result[team].players[index]
                                                .playerNumber ==
                                            null ||
                                        state.teamsresponse.result[team]
                                                .players[index].playerNumber ==
                                            ""
                                    ? "2"
                                    : state.teamsresponse.result[team]
                                            .players[index].playerNumber ??
                                        '12',
                                style: const TextStyle(
                                    fontFamily: "Tahoma",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              const Text(
                                " Number",
                                style: TextStyle(
                                  fontFamily: "Tahoma",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  state
                                                  .teamsresponse
                                                  .result[team]
                                                  .players[index]
                                                  .playerYellowCards ==
                                              null ||
                                          state
                                                  .teamsresponse
                                                  .result[team]
                                                  .players[index]
                                                  .playerYellowCards ==
                                              ""
                                      ? "1"
                                      : state.teamsresponse.result[team]
                                          .players[index].playerYellowCards!,
                                  style: const TextStyle(
                                      fontFamily: "Tahoma",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                const Text(
                                  "Yellow Card",
                                  style: TextStyle(
                                      fontFamily: "Tahoma",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  state
                                                  .teamsresponse
                                                  .result[team]
                                                  .players[index]
                                                  .playerRedCards ==
                                              null ||
                                          state
                                                  .teamsresponse
                                                  .result[team]
                                                  .players[index]
                                                  .playerRedCards ==
                                              ""
                                      ? "2"
                                      : state.teamsresponse.result[team]
                                          .players[index].playerRedCards!,
                                  style: const TextStyle(
                                      fontFamily: "Tahoma",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                const Text(
                                  "Red Cards",
                                  style: TextStyle(
                                      fontFamily: "Tahoma",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  state
                                                  .teamsresponse
                                                  .result[team]
                                                  .players[index]
                                                  .playerAssists ==
                                              null ||
                                          state
                                                  .teamsresponse
                                                  .result[team]
                                                  .players[index]
                                                  .playerAssists ==
                                              ""
                                      ? "Ricardo"
                                      : state.teamsresponse.result[team]
                                          .players[index].playerAssists!,
                                  style: const TextStyle(
                                      fontFamily: "Tahoma",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                const Text(
                                  "Assits",
                                  style: TextStyle(
                                      fontFamily: "Tahoma",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20),
                      //   child: Container(
                      //     width: 100,
                      //     height: 30,

                      //     child: Center(
                      //       child: ElevatedButton(
                      //           onPressed: () async {
                      //             // ignore: non_constant_identifier_names
                      //             final uri = Uri.parse(
                      //                 "https://apiv2.allsportsapi.com/football/?&met=Players&teamId=10&APIkey=da248f5665aa5f3116c16ddc9a5e3a9841870cb50ff81537c8f4e970c678e876");

                      //             final res = await http.get(Uri as Uri);
                      //             final bytes = res.bodyBytes;
                      //             final temp = await getTemporaryDirectory();

                      //             final path =
                      //                 ' ${temp.path} /state.response.result[index].playerAge';
                      //             File(path).writeAsBytesSync(bytes);

                      //             // ignore: deprecated_member_use
                      //             await Share.shareFiles([path]);
                      //           },
                      //           child: Text("Share")),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 150,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: const Color(0xff383542),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: CachedNetworkImage(
                    width: 80,
                    height: 80,
                    imageUrl: state
                        .teamsresponse.result[team].players[index].playerImage!,
                    errorWidget: (context, url,
                            error) => //شالت الصوره الي فيها error
                        Image.network(
                            "https://thumbs.dreamstime.com/b/mo-salah-professional-footballer-vector-image-bandung-indonesia-march-mo-salah-professional-footballer-vector-image-242630646.jpg"),
                    placeholder: (context, url) => Image.network(
                        "https://thumbs.dreamstime.com/b/mo-salah-professional-footballer-vector-image-bandung-indonesia-march-mo-salah-professional-footballer-vector-image-242630646.jpg"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
