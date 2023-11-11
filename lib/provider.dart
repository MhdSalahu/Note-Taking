import 'package:flutter/foundation.dart';

class NoteData extends ChangeNotifier {
  List<String> notesList = [];
  List<String> titleList = [];
  List<String> categoryList = [];
  List<String> dateList = [];

  void addNote(String note, String title, String category, String date) {
    notesList.add(note);
    titleList.add(title);
    categoryList.add(category);
    dateList.add(date);
    notifyListeners();
  }
}
