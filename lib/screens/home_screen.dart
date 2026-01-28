import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaultnote/providers/note_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteProvider = context.watch<NoteProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("EXOTIC NOTES", style: TextStyle(letterSpacing: 3)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF0D0221),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF19112E)),
              child: Center(
                child: Text(
                  "DATA MANAGEMENT",
                  style: TextStyle(color: Color(0xFF00FFC8), letterSpacing: 2),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.upload_file, color: Colors.amberAccent),
              title: const Text("Export JSON (Backup)"),
              onTap: () => noteProvider.exportNotes(),
            ),
            ListTile(
              leading: const Icon(
                Icons.download_for_offline,
                color: Color(0xFF00FFC8),
              ),
              title: const Text("Import JSON (Restore)"),
              onTap: () async {
                bool success = await noteProvider.importNotes();
                if (success && context.mounted) {
                  Navigator.pop(context); // Close drawer
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Notes synchronized successfully!"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: noteProvider.notes.isEmpty
          ? const Center(
              child: Text("Your journey begins with a single note..."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: noteProvider.notes.length,
              itemBuilder: (context, index) {
                final note = noteProvider.notes[index];
                return Dismissible(
                  key: Key(note.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.delete_sweep,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                  ),
                  onDismissed: (direction) async {
                    final deletedNote = note;
                    final provider = context.read<NoteProvider>();

                    final originalIndex = await provider.deleteNote(note.id);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Successfully Removed the Note"),
                          action: SnackBarAction(
                            label: "UNDO",
                            onPressed: () =>
                                provider.insertNote(originalIndex, deletedNote),
                          ),
                        ),
                      );
                    }
                  },
                  child: Card(
                    color: const Color(0xFF19112E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        note.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF00FFC8),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          note.location,
                          style: const TextStyle(color: Colors.amberAccent),
                        ),
                      ),
                      onTap: () => {},
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00FFC8),
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () => {},
      ),
    );
  }
}
