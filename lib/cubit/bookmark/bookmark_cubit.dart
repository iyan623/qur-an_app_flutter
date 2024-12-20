import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());

  static const String _key = 'bookmarks';

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_key) ?? [];
    emit(BookmarkLoaded(bookmarks));
  }

  Future<void> addBookmark(String item) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_key) ?? [];

    if (!bookmarks.contains(item)) {
      bookmarks.add(item);
      await prefs.setStringList(_key, bookmarks);
      emit(BookmarkLoaded(bookmarks));
    }
  }

  Future<void> removeBookmark(String item) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_key) ?? [];

    if (bookmarks.contains(item)) {
      bookmarks.remove(item);
      await prefs.setStringList(_key, bookmarks);
      emit(BookmarkLoaded(bookmarks));
    }
  }
}
