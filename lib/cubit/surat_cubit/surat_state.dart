part of 'surat_cubit.dart';

@immutable
sealed class SuratState {}

final class SuratInitial extends SuratState {}

final class SuratLoading extends SuratState {}

final class SuratLoaded extends SuratState {
  final List<Surat> surat;

  SuratLoaded(this.surat);
}

final class SuratError extends SuratState {
  final String message;

  SuratError(this.message);
}
