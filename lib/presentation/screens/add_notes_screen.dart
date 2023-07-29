import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/note.dart';
import '../../providers/note_provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  AddNoteScreenState createState() => AddNoteScreenState();
}

class AddNoteScreenState extends State<AddNoteScreen> {
  String title = '';
  String content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add Note', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () => _onSavedClicked(context),
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              onChanged: (value) => setState(() => title = value.trim()),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
              ),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(height: 16),
            Expanded(
              child: TextFormField(
                onChanged: (value) => setState(() => content = value.trim()),
                maxLines: 30,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Content',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSavedClicked(BuildContext context) async {
    if (title.trim().isEmpty && content.trim().isEmpty) {
      return;
    }
    final newNote = Note(
      title: title,
      content: content,
      modifiedTime: DateTime.now(),
    );
    await context.read<NoteProvider>().addNote(newNote);
    Navigator.pop(context);
  }
}
