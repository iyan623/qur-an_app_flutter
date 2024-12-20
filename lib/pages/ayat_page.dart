import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../cubit/bookmark/bookmark_cubit.dart';
import '../widgets/audio_player_widget.dart';
import '../cubit/ayat_cubit/ayat_cubit.dart';
import '../data/model/surat_model.dart';

class AyatPage extends StatelessWidget {
  final Surat surat;
  const AyatPage({
    super.key,
    required this.surat,
  });

  @override
  Widget build(BuildContext context) {
    context.read<AyatCubit>().getAyat(surat.nomor!);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF004B40).withOpacity(0.20),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFF004B40),
            ),
            icon: const Icon(
              Icons.arrow_back,
              size: 24.0,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          "Ayat",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: const Color(0xFF004B40),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 14),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/images/Card.png",
                width: double.infinity,
                height: 350.0,
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  Text(
                    '${surat.namaLatin}',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'The Opening',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 100),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${surat.tempatTurun}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        '|',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        '${surat.jumlahAyat} Ayat',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Image.asset(
                    "assets/images/basmalah.png",
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 65.0),
                ],
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<AyatCubit, AyatState>(
              builder: (context, state) {
                if (state is AyatLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is AyatLoaded) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 48,
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF5C8E79),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () async {
                                    await Share.share(
                                      "Allah Subhanahu Wa Ta'ala berfirman :\n\n"
                                      "${state.ayat[index + 1].teksArab}\n"
                                      "${state.ayat[index + 1].teksLatin}\n\n"
                                      "\"${state.ayat[index + 1].teksIndonesia}\"\n"
                                      "(QS. ${surat.namaLatin} ${surat.nomor}: Ayat ${index + 1})",
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    color: Color(0xFF5C8E79),
                                  ),
                                ),
                                AudioPlayerWidget(
                                  audioUrl:
                                      "${state.ayat[index + 1].audio?['05']}",
                                ),
                                IconButton(
                                  onPressed: () {
                                    final itemBookmark =
                                        "QS. ${surat.namaLatin} ${surat.nomor}: Ayat ${state.ayat[index + 1].nomorAyat} ";
                                    context
                                        .read<BookmarkCubit>()
                                        .addBookmark(itemBookmark);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Tersimpan di Bookmark!'),
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Color(0xFF18392B),
                                        shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.bookmark),
                                  color: const Color(0xFF5C8E79),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 18.0),
                          Text(
                            "${state.ayat[index + 1].teksArab}",
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF18392B),
                              fontSize: 22,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Container(
                            width: double.infinity,
                            margin:
                                const EdgeInsets.only(bottom: 10.0, top: 20),
                            child: Text(
                              "${state.ayat[index + 1].teksIndonesia}",
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF18392B),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            height: 0.8,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 15),
                            color: const Color(0xFFBBC4CE).withOpacity(
                              0.4,
                            ),
                          ),
                          const SizedBox(height: 14.0),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 5);
                    },
                    itemCount: state.ayat.length - 1,
                  );
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
