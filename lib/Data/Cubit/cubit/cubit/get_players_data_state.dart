part of 'get_players_data_cubit.dart';



@immutable
sealed class GetPlayersDataState {}

final class GetPlayersDataInitial extends GetPlayersDataState {}

final class GetPlayersSuccess extends GetPlayersDataState {
  final GetPlayersModel response;
  GetPlayersSuccess({required this.response});
}

final class GetPlayersLoading extends GetPlayersDataState {}

final class GetPlayersError extends GetPlayersDataState {}