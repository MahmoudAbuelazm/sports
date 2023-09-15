import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'button_cubit_state.dart';

class ButtonCubitCubit extends Cubit<ButtonCubitState> {
  ButtonCubitCubit() : super(ButtonCubitInitial());
  void Button() {
    emit(CounterChange());
}
}