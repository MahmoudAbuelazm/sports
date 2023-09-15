import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sports_app/Data/Models/data/leagues.dart';
import 'package:sports_app/Data/Rpository/leagues_repo.dart';
// import 'package:meta/meta.dart';


part 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  LeaguesCubit() : super(LeaguesInitial());
  LeaguesRepo leaguesRepo = LeaguesRepo();

      getAllLeagues ( countryId ) async{
    emit(LeaguesLoading());
    try {
        await leaguesRepo.getAllLeagues(countryId).then((value) {
      if (value != null) {
        emit(LeaguesSuccess(response: value));
      } else {
        emit(LeaguesFailure());
        debugPrint("request failed");
      }
    });
    } catch (e) {
      print(e); 
    }
   


  }
}
