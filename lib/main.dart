import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/audio_player_cubit/audio_player_cubit.dart';
import '../cubit/bookmark/bookmark_cubit.dart';
import '../pages/spalash_page.dart';
import '../cubit/ayat_cubit/ayat_cubit.dart';
import '../cubit/local_cubit/local_cubit.dart';
import '../cubit/surat_cubit/surat_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookmarkCubit()),
        BlocProvider(create: (context) => SuratCubit()),
        BlocProvider(create: (context) => AyatCubit()),
        BlocProvider(create: (context) => AudioPlayerCubit()),
        BlocProvider(create: (context) => LocalCubit(shared: prefs)),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Al-Quran",
        home: SplashScreen(),
      ),
    );
  }
}
