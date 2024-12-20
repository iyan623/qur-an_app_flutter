import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/audio_player_cubit/audio_player_cubit.dart';
import '../cubit/audio_player_cubit/audio_player_state.dart';

class AudioPlayerWidget extends StatelessWidget {
  final String? audioUrl;

  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioPlayerCubit(),
      child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
        builder: (context, state) {
          final audioCubit = context.read<AudioPlayerCubit>();

          return IconButton(
            onPressed: () {
              if (audioUrl != null && audioUrl!.isNotEmpty) {
                if (state is AudioPlaying) {
                  audioCubit.pauseAudio();
                } else {
                  audioCubit.playAudio(audioUrl!);
                }
              }
            },
            icon: Icon(
              state is AudioPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              color: const Color(0xFF5C8E79),
            ),
          );
        },
      ),
    );
  }
}
