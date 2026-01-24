import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
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

  Future<void> _saveToFile() async {
    final file = await _localFile;
    final String jsonString = json.encode(
      _notes.map((n) => n.toJson()).toList(),
    );
    await file.writeAsString(jsonString);
  }

  Future<void> addNote(Note note) async {
    _notes.add(note);
    await _saveToFile();
    notifyListeners();
  }

  Future<void> updateNote(Note updatedNote) async {
    final index = _notes.indexWhere((n) => n.id == updatedNote.id);
    if (index != -1) {
      _notes[index] = updatedNote;
      await _saveToFile();
      notifyListeners();
    }
  }

  // UPDATED: Modern share_plus syntax
  Future<void> exportNotes() async {
    final file = await _localFile;
    if (await file.exists()) {
      await SharePlus.instance.share(
        ShareParams(text: 'My Exotic Notes Backup', files: [XFile(file.path)]),
      );
    }
  }

  Future<bool> importNotes() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        File selectedFile = File(result.files.single.path!);
        String content = await selectedFile.readAsString();
        List<dynamic> jsonList = json.decode(content);

        _notes = jsonList.map((j) => Note.fromJson(j)).toList();
        await _saveToFile();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Import failed: $e");
      return false;
    }
  }
}
