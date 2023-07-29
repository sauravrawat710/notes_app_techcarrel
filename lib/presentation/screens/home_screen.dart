import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app_techcarrel/presentation/widgets/my_staggered_tile_widget.dart';
import '../../models/note.dart';
import '../../providers/note_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey stagKey = GlobalKey();
  List<Note> notes = [];

  @override
  void didChangeDependencies() {
    notes = context.watch<NoteProvider>().notes;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Notes (TechCarrel)',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<NoteProvider>().fetchNotes();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: _paddingForView(context),
        child: SingleChildScrollView(
          child: StaggeredGrid.count(
            key: GlobalKey(),
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            children: List.generate(
              notes.length,
              (index) => StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: Hero(
                  tag: 'note-${notes[index].id}',
                  child: MyStaggeredTile(note: notes[index]),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  EdgeInsets _paddingForView(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double padding;
    double topBottom = 8;
    if (width > 500) {
      padding = (width) * 0.05; // 5% padding of width on both side
    } else {
      padding = 8;
    }
    return EdgeInsets.only(
        left: padding, right: padding, top: topBottom, bottom: topBottom);
  }
}
