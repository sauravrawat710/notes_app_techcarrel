class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime modifiedTime;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      modifiedTime: DateTime.fromMillisecondsSinceEpoch(map['modifiedTime']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'modifiedTime': modifiedTime.millisecondsSinceEpoch,
    };
  }

  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? modifiedTime,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      modifiedTime: modifiedTime ?? this.modifiedTime,
    );
  }
}
