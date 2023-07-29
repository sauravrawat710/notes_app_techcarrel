import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_techcarrel/models/note.dart';
import 'dart:math' as math;

import 'package:timeago/timeago.dart' as timeago;

class MyStaggeredTile extends StatefulWidget {
  final Note note;
  const MyStaggeredTile({required this.note, super.key});
  @override
  MyStaggeredTileState createState() => MyStaggeredTileState();
}

class MyStaggeredTileState extends State<MyStaggeredTile> {
  late String _content;
  late double _fontSize;
  late Color tileColor;
  late String title;

  @override
  Widget build(BuildContext context) {
    _content = widget.note.content;
    _fontSize = _determineFontSizeForContent();
    tileColor =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(.35);
    title = widget.note.title;

    return GestureDetector(
      onTap: () => _noteTapped(context),
      child: Container(
        decoration: BoxDecoration(
            border: tileColor == Colors.white
                ? Border.all(color: Colors.black)
                : null,
            color: tileColor,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.all(8),
        child: constructChild(),
      ),
    );
  }

  void _noteTapped(BuildContext ctx) {
    Navigator.of(context).pushNamed('/note-details', arguments: {
      'id': widget.note.id,
    });
  }

  Widget constructChild() {
    List<Widget> contentsOfTiles = [];

    if (widget.note.title.isNotEmpty) {
      contentsOfTiles.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AutoSizeText(
                title,
                style:
                    TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold),
                maxLines: 3,
                textScaleFactor: 1.5,
              ),
            ),
            Text(
              timeago.format(widget.note.modifiedTime),
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      );
      contentsOfTiles.add(const Divider(color: Colors.transparent, height: 6));
    }

    contentsOfTiles.add(AutoSizeText(
      _content,
      style: TextStyle(fontSize: _fontSize),
      maxLines: 10,
      textScaleFactor: 1.5,
    ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: contentsOfTiles,
    );
  }

  double _determineFontSizeForContent() {
    int charCount = _content.length + widget.note.title.length;
    double fontSize = 20;
    if (charCount > 110) {
      fontSize = 12;
    } else if (charCount > 80) {
      fontSize = 14;
    } else if (charCount > 50) {
      fontSize = 16;
    } else if (charCount > 20) {
      fontSize = 18;
    }
    return fontSize;
  }
}
