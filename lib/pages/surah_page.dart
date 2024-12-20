import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import './bookmark_page.dart';
import '../cubit/local_cubit/local_cubit.dart';
import '../cubit/surat_cubit/surat_cubit.dart';
import '../pages/ayat_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    final suratCubit = context.read<SuratCubit>();
    suratCubit.getSurat();
    final lastReadCubit = context.read<LocalCubit>();
    lastReadCubit.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "Al-",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Q",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF588B76),
                    ),
                  ),
                  Text(
                    "ur'an",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BookmarkPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.book_outlined,
                      color: Color(0xFF588B76),
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Stack(
                children: [
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/Frame30.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.menu_book_sharp,
                              size: 24.0,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Last Read",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 75),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<LocalCubit, String>(
                              builder: (context, state) {
                                return Text(
                                  state,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              height: 40,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF588B76),
                    Color(0xFFD0DED8),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  "Surah",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SuratCubit, SuratState>(
                builder: (context, state) {
                  if (state is SuratLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SuratLoaded) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      itemBuilder: (context, index) {
                        final surat = state.surat[index];
                        return InkWell(
                          onTap: () {
                            context
                                .read<LocalCubit>()
                                .saveData(surat.namaLatin!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AyatPage(
                                  surat: surat,
                                ),
                              ),
                            );
                          },
                          splashColor:
                              const Color(0xFFBBC4CE).withOpacity(0.12),
                          highlightColor: const Color(0xFFBBC4CE).withOpacity(
                            0.12,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                const SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Image.asset(
                                          "assets/images/ayat_number.png",
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 16.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          surat.namaLatin!,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: const Color(0xFF18392B),
                                          ),
                                        ),
                                        const SizedBox(height: 6.0),
                                        Row(
                                          children: [
                                            Text(
                                              "${surat.tempatTurun}",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: const Color(0xFF8789A3)
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "|",
                                              style: TextStyle(
                                                color: const Color(0xFF8789A3)
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "${surat.jumlahAyat} Ayat",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: const Color(0xFF8789A3)
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      surat.nama!,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22,
                                        color: const Color(0xFF588B76),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 0.8,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 15),
                                  color: const Color(0xFFBBC4CE).withOpacity(
                                    0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                      itemCount: state.surat.length,
                    );
                  }
                  return const Center(
                    child: Text("Error"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
