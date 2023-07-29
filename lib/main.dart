import 'package:flutter/material.dart';
import 'presentation/screens/add_notes_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/note_details_screen.dart';
import 'providers/note_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProvider()..fetchNotes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/add': (context) => const AddNoteScreen(),
          '/note-details': (context) => const NoteDetailsScreen(),
        },
      ),
    );
  }
}
