import 'package:flutter/material.dart';
import 'package:vaultnote/models/note.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;
  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late TextEditingController _contentController;
  bool _isEditing = false; // Track if we are in edit mode

  @override
  void initState() {
    super.initState();
    _isEditing = widget.note == null; // New notes start in edit mode
    _titleController = TextEditingController(text: widget.note?.title ?? "");
    _locationController = TextEditingController(
      text: widget.note?.location ?? "",
    );
    _contentController = TextEditingController(
      text: widget.note?.content ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: const Color(0xFF00FFC8),
            ),
            onPressed: () {
              if (_isEditing) {
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                enabled: _isEditing, // Disable input when just viewing
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00FFC8),
                ),
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _locationController,
                enabled: _isEditing,
                style: const TextStyle(color: Colors.amberAccent),
                decoration: const InputDecoration(
                  hintText: "Location",
                  border: InputBorder.none,
                ),
              ),
              const Divider(color: Colors.white24),
              TextField(
                controller: _contentController,
                enabled: _isEditing,
                maxLines: null,
                style: const TextStyle(fontSize: 16, height: 1.5),
                decoration: const InputDecoration(
                  hintText: "Your exotic thoughts...",
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
