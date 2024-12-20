import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '/data/api_request.dart';
import '/data/model/surat_model.dart';

part 'surat_state.dart';

class SuratCubit extends Cubit<SuratState> {
  SuratCubit() : super(SuratInitial());

  void getSurat() async {
    emit(SuratLoading());
    await getSuratData().then(
      (value) {
        emit(SuratLoaded(value));
      },
    ).catchError(
      (onError) {
        emit(SuratError(onError.toString()));
      },
    );
  }
}
