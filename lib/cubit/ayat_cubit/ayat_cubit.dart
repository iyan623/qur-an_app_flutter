import 'package:bloc/bloc.dart';
import '/data/api_request.dart';
import '/data/model/ayat_model.dart';

part 'ayat_state.dart';

class AyatCubit extends Cubit<AyatState> {
  AyatCubit() : super(AyatInitial());

  Future<void> getAyat(int nomor) async {
    emit(AyatLoading());
    await getAyatData(nomor).then(
      (value) {
        emit(AyatLoaded(value));
      },
    ).catchError(
      (onError) {
        emit(AyatError(onError.toString()));
      },
    );
  }
}
