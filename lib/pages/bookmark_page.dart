import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/bookmark/bookmark_cubit.dart';
import '../cubit/bookmark/bookmark_state.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkCubit()..loadBookmarks(),
      child: Scaffold(
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
            "Bookmarks",
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: const Color(0xFF004B40),
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            if (state is BookmarkLoaded) {
              final bookmarks = state.bookmarks;
              if (bookmarks.isEmpty) {
                return const Center(child: Text("Belum ada bookmark"));
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final item = bookmarks[index];
                  return ListTile(
                    title: Text(
                      item,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<BookmarkCubit>().removeBookmark(item);
                      },
                    ),
                    leading: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xff004B40),
                        ),
                        const CircleAvatar(
                          maxRadius: 15,
                          backgroundColor: Colors.white,
                        ),
                        Text(
                          '${index + 1}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
