import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../Data/Cubit/Leagues Cubit/leagues_cubit.dart';
import '../Data/Cubit/cubit/git_country_cubit.dart';
import 'leagues.dart';

class CountryScreen extends StatefulWidget {
  var response;
  CountryScreen({super.key, required this.response});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  String? _currentAddress;
  Position? _currentPosition;
  String? _userCountry;
  ScrollController _scrollController = ScrollController();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      localeIdentifier: "en_US",
    ).then((List<Placemark> placemarks) {
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress =
              '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}';
          _userCountry = place.country; // Get the user's country
        });
      } else {
        setState(() {
          _currentAddress = "Address not found";
        });
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "Images/Background.png",
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "All Country",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 60,
              ),
            ],
          ),
        ),
        body: Container(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .06,
                                width: MediaQuery.of(context).size.width * .8,

                                child: Center(
                                  child: TextField(
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900),
                                    decoration: InputDecoration(
                                      filled: true, //<-- SEE HERE
                                      fillColor: Colors.transparent,
                                      hintText: "Current location",
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 36, 4, 240),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      // border: ,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 42, 2, 95),
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      // border:
                                    ),
                                  ),
                                ),

                                // height: MediaQuery.of(context).size.height * .07,
                                // width: MediaQuery.of(context).size.width * .8,
                                // child: Center(
                                //     child: Text("Current location",
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontWeight: FontWeight.w900))),
                                // decoration: BoxDecoration(
                                //   border: Border.all(
                                //       color: Color.fromARGB(255, 42, 2, 95),
                                //       width: 2.0),
                                //   borderRadius: BorderRadius.circular(50),
                                //   color: Color.fromARGB(255, 60, 60, 60),
                                // ),
                              ),
                              IconButton(
                                icon: Icon(Icons.location_on),
                                color: Colors.grey,
                                highlightColor: Colors.transparent,
                                onPressed: _getCurrentPosition,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  //             Navigator.push(
                                  // context,
                                  // MaterialPageRoute(
                                  //     builder: (context) => const AddAddressScreen()));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .07,
                                  width: MediaQuery.of(context).size.width * .3,
                                  child: Center(
                                      child: Text("Open GM",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900))),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPy9xoCiIHtNBp4PUQBsrlkMLvCqgz24sXkg&usqp=CAU",
                                        ),
                                        fit: BoxFit.cover),
                                    border: Border.all(
                                        color: Color.fromARGB(255, 42, 2, 95),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color.fromARGB(255, 60, 60, 60),
                                  ),
                                ),
                              ),
                            ],
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
                                  itemBuilder: (context, i) {
                                    var countryId = state
                                        .response.result[i].countryKey
                                        .toString();
                                    var countryName = state
                                        .response.result[i].countryName
                                        .toString();
                                    var countryLogo = state
                                        .response.result[i].countryLogo
                                        .toString();
                                    // var countryName = state.response.result[i].countryName.toString();

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                LeaguesScreen(
                                              countryId: countryId,
                                              countryName: countryName,
                                              countryLogo: countryLogo,
                                            ),
                                          ),
                                        );
                                        final leages = context
                                            .read<LeaguesCubit>()
                                            .getAllLeagues(state
                                                .response.result[i].countryKey
                                                .toString());
                                        context
                                            .read<LeaguesCubit>()
                                            .getAllLeagues(state
                                                .response.result[i].countryKey
                                                .toString());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1 /
                                              15,

                                          width: double.infinity,

                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 42, 2, 95),
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
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  child: Image(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .17,
                                                    height:
                                                        MediaQuery.of(context)
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
      ),
    );
  }
}
