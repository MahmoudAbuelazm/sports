part of 'get_top_scorer_cubit.dart';

@immutable
sealed class GetTopScorerState {}

final class GetTopScorerInitial extends GetTopScorerState {}

final class GetTopScorerLoading extends GetTopScorerState {}

final class GetTopScorerSuccess extends GetTopScorerState {
  final GetTopScorerModel response;
  GetTopScorerSuccess({required this.response});
}

final class GetTopScorerEror extends GetTopScorerState {}
