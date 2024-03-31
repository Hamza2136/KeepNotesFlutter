class Note {
  final int id;
  final String title;
  final String date;
  final String priority;
  String? description;

  Note({
    required this.id,
    required this.title,
    required this.date,
    required this.priority,
    this.description,
  });

  factory Note.fromSqfliteDatabase(Map<String, dynamic> map) => Note(
        id: map['id'] as int,
        title: map['title'] as String,
        priority: map['priority'] as String,
        description: map['description'] as String?,
        date: map['date'] as String,
      );
}
