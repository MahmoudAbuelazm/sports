import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/Data/Cubit/Leagues%20Cubit/leagues_cubit.dart';
import 'package:sports_app/Screen/leagues.dart';
// import 'package:http/http.dart';

import '../Data/Cubit/cubit/git_country_cubit.dart';

class CountryScreen extends StatefulWidget {
  var response;
  CountryScreen({super.key, required this.response});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "All Country",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "Images/Background.png",
                ),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Text("asdfghjkl" ,style: TextStyle(color: Colors.amber),),
              //     Container(
              //       decoration: BoxDecoration(

              //       ),
              //     ),

              //     Icon(Icons.location_on_outlined, color: Colors.blue,),

              //   ],
              // ),

              // ElevatedButton(onPressed: (){
              //   context.read<GitCountryCubit>().gitCountry();
              // }, child: Text("prees")),
              BlocBuilder<GitCountryCubit, GitCountryState>(
                builder: (context, state) {
                  // if (state is GitCountryInitial) {
                  //   return Text("waaiiiiiiiiit");
                  // }
                  if (state is GitCountryloading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GitCountrySuccess) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                                itemCount: state.response.result.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (context, i)
                                 {
                                  var countryId = state.response.result[i].countryKey.toString();
                                  var countryName = state.response.result[i].countryName.toString();
                                  var countryLogo = state.response.result[i].countryLogo.toString();
                                  // var countryName = state.response.result[i].countryName.toString();

                                  return GestureDetector(
                                    onTap: (){
                                       Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>   LeaguesScreen(countryId: countryId , countryName: countryName,countryLogo: countryLogo,),
                                            ),
                                          );
                          final leages = context.read<LeaguesCubit>().getAllLeagues(state.response.result[i].countryKey.toString());
                          context.read<LeaguesCubit>().getAllLeagues(state.response.result[i].countryKey.toString());
                          
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1 /
                                                15,
                                      
                                        width: double.infinity,
                                      
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Color.fromARGB(255, 42, 2, 95),
                                              width: 2.0),
                                          // borderRadius: BorderRadius.circular(50.0)
                                        ),
                                      
                                        //     decoration: const BoxDecoration(
                                        // gradient: LinearGradient(
                                        //     // begin: Alignment.center,
                                        //     // end: Alignment.bottomRight,
                                        //     colors: [
                                        //   Colors.black,
                                        //   Color(0xFF1F0048),
                                      
                                        // ])
                                      
                                        // ),
                                        // decoration: BoxDecoration(
                                        //     color: Color.fromARGB(
                                        //         255, 195, 197, 232),
                                        //     gradient: LinearGradient(colors: [
                                        //       Color(0x2BC8C8C8),
                                        //       Color(0xFF2F0141),
                                        //     ])),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Expanded(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  child: Image(
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        .17,
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        .05,
                                                    image: NetworkImage(state
                                                            .response
                                                            .result[i]
                                                            .countryLogo ??
                                                        'https://cdn.alweb.com/thumbs/egyptencyclopedia/article/fit710x532/%D8%B9%D9%84%D9%85-%D9%85%D8%B5%D8%B1-%D8%A3%D9%87%D9%85-%D8%A7%D9%84%D8%AD%D9%82%D8%A7%D8%A6%D9%82.jpg'),
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   height: 1,
                                                // ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                      
                                                Expanded(
                                                  child: Text(
                                                    state.response.result[i]
                                                        .countryName,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }))
                      ],
                    );
                  } else {
                    return Text("");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
