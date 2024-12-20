part of 'ayat_cubit.dart';

sealed class AyatState {}

final class AyatInitial extends AyatState {}

final class AyatLoading extends AyatState {}

final class AyatLoaded extends AyatState {
  final List<AyatModel> ayat;

  AyatLoaded(this.ayat);
}

final class AyatError extends AyatState {
  final String error;

  AyatError(this.error);
}
