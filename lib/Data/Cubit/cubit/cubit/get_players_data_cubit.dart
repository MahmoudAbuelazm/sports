import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:sports_app/Data/Models/get_players_model.dart';
import 'package:sports_app/Data/Rpository/get_players_repo.dart';

part 'get_players_data_state.dart';

class GetPlayersDataCubit extends Cubit<GetPlayersDataState> {
  GetPlayersDataCubit() : super(GetPlayersDataInitial());

  GetPlayersRepo playersRepo = GetPlayersRepo();
  gitPlayers() async {
    emit(GetPlayersLoading());
    try {
      await playersRepo.getPlayers().then((value) {
        if (value != null) {
          emit(GetPlayersSuccess(response: value));
        } else {
          emit(GetPlayersError());
        }
      });
    } catch (error) {
      emit(GetPlayersError());
    }
  }

  GetPlayersModel? model;
  getSearchPlayers(String playerName) async {
    emit(GetPlayersLoading());
    try {
      await playersRepo.searchPlayers(playerName).then((value) {
        if (value != null) {
          model = value;
          emit(GetPlayersSuccess(response: value));
        } else {
          emit(GetPlayersError());
        }
      });
    } catch (error) {
      emit(GetPlayersError());
    }
  }
}
