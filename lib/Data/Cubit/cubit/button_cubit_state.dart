part of 'button_cubit_cubit.dart';

@immutable
sealed class ButtonCubitState {}

final class ButtonCubitInitial extends ButtonCubitState {}
final class CounterChange extends ButtonCubitState {}