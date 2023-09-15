import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:sports_app/Data/Models/get_topScorer_model.dart';
import 'package:sports_app/Data/Rpository/get_topScorer_repo.dart';



part 'get_top_scorer_state.dart';

class GetTopScorerCubit extends Cubit<GetTopScorerState> {
  GetTopScorerCubit() : super(GetTopScorerInitial());

  GetTopScorerRepo topScorerRepo = GetTopScorerRepo();
  getTopScorer() async {
    emit(GetTopScorerLoading());

    try {
      await topScorerRepo.getGoals().then((value) {
        if (value != null) {
          emit(GetTopScorerSuccess(response: value));
        } else {
          emit(GetTopScorerEror());
        }
      });
    } catch (error) {
      emit(GetTopScorerEror());
    }
  }
}
