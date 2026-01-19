import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vaultnote/models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/notes.json');
  }

  Future<void> loadNotes() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final String contents = await file.readAsString();
        final List<dynamic> jsonList = json.decode(contents);
        _notes = jsonList.map((json) => Note.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading notes: $e");
    }
  }
}
