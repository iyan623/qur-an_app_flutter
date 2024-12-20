import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayerCubit() : super(AudioInitial());

  Future<void> playAudio(String url) async {
    try {
      await _audioPlayer.play(UrlSource(url));
      emit(AudioPlaying());
    } catch (e) {
      (onError) {
        emit(AudioEror(onError.toString()));
      };
    }
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    emit(AudioPaused());
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
