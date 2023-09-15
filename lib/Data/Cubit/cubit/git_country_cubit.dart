import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sports_app/Data/Rpository/git_country_repo.dart';

import '../../Models/git_country_model.dart';

part 'git_country_state.dart';

class GitCountryCubit extends Cubit<GitCountryState> {
  GitCountryCubit() : super(GitCountryInitial());
  GitCountryRepo countryRepo = GitCountryRepo();

  gitCountry() async {
    emit(GitCountryloading());
    try {
      await countryRepo.GitCountry().then((value) {
        if (value != null) {
          emit(GitCountrySuccess(response: value));
        } else {
          emit(GitCountryErorr());
        }
      });
    } catch (erorr) {
      emit(GitCountryErorr());
    }
  }
}
