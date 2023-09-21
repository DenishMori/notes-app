class Note {
  int? id;
  String? title;
  String? note;

  Note({
    this.id,
    this.title,
    this.note,
  });

  Note copyWith({int? id, String? title, String? note}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        id: json['note_id'] as int,
        title: json['note_title'] != null ? json['note_title'] as String : "",
        note: json['note_desc'] != null ? json['note_desc'] as String : "");
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'note_title': title,
      'note_desc': note,
    };
  }

  @override
  String toString() {
    return 'Note(note_id: $id, note_title: $title, note_desc: $note)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.note == note;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ note.hashCode;
}
