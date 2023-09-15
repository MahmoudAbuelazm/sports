part of 'leagues_cubit.dart';

@immutable
abstract class LeaguesState {}

class LeaguesInitial extends LeaguesState {}

class LeaguesLoading extends LeaguesState {}

class LeaguesSuccess extends LeaguesState {
  final Leagues response;
  LeaguesSuccess({required this.response});
}

class LeaguesFailure extends LeaguesState {}
