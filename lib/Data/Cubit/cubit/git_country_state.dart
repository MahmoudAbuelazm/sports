      part of 'git_country_cubit.dart';

@immutable
sealed class GitCountryState {}

final class GitCountryInitial extends GitCountryState {}
final class GitCountryloading extends GitCountryState {}
final class GitCountrySuccess extends GitCountryState {
     final GitCountryModel response;
     GitCountrySuccess({required this.response}) ;


}
final class GitCountryErorr extends GitCountryState {}
