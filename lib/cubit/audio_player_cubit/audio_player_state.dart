abstract class AudioPlayerState {}

class AudioInitial extends AudioPlayerState {}

class AudioPlaying extends AudioPlayerState {}

class AudioPaused extends AudioPlayerState {}

final class AudioEror extends AudioPlayerState {
  final String error;

  AudioEror(this.error);
}
