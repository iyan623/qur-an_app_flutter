abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<String> bookmarks;

  BookmarkLoaded(this.bookmarks);
}
