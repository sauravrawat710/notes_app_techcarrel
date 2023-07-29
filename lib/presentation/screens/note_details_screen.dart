import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../../providers/note_provider.dart';
import 'package:provider/provider.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({super.key});

  @override
  NoteDetailsScreenState createState() => NoteDetailsScreenState();
}

class NoteDetailsScreenState extends State<NoteDetailsScreen> {
  late Note note;
  String title = '';
  String content = '';

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments! as Map;

    note = context
        .read<NoteProvider>()
        .notes
        .firstWhere((element) => element.id == args['id']);

    title = note.title;
    content = note.content;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            const Text('Note Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () async => await _onDeleteClicked(context),
            icon: const Icon(Icons.delete_forever_outlined),
          ),
          IconButton(
            onPressed: () async => await _onUpdateClicked(context),
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Hero(
          tag: 'note-${note.id}',
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: note.title,
                  onChanged: (value) => setState(() => title = value.trim()),
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Divider(height: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: note.content,
                    onChanged: (value) =>
                        setState(() => content = value.trim()),
                    maxLines: 30,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onDeleteClicked(BuildContext context) async {
    await context.read<NoteProvider>().deleteNote(note.id!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note deleted'),
        backgroundColor: Colors.red,
      ),
    );
    Navigator.pop(context);
  }

  Future<void> _onUpdateClicked(BuildContext context) async {
    final updatedNote = note.copyWith(
      title: title,
      content: content,
      modifiedTime: DateTime.now(),
    );

    print(updatedNote.toMap());

    await context.read<NoteProvider>().updateNote(updatedNote);
    Navigator.pop(context);
  }
}
