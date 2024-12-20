import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/data/local_storage.dart';

class LocalCubit extends Cubit<String> {
  final SharedPreferences shared;

  LocalCubit({required this.shared}) : super("-");

  void saveData(String name) async {
    saveLastRead(name, shared);
    emit(name);
  }

  Future<void> getData() async {
    var data = await getLastRead(shared);
    emit(data.isEmpty ? "" : data);
  }
}
