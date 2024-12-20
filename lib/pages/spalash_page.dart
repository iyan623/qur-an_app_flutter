import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './surah_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  "Al-Qur'an",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: const Color(0xff18392B)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Memorize and recite\nQuran easily",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: const Color(0xff8789A3),
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset(
                      "assets/images/splashscreen.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      width: 185,
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const DashboardPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffD0DED8)),
                        child: Text(
                          "Get Started",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: const Color(0xff18392B),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
