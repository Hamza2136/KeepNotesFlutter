// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import 'package:keepnotes/utils/database_service.dart';
import 'package:keepnotes/models/note.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class NotesDb {
  final noteTable = 'notes';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $noteTable (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "priority" TEXT NOT NULL,
    description Text
    );""");
  }

  Future<int> create({
    required String title,
    required String priority,
    String? description,
  }) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $noteTable (title, date, priority, description) VALUES(?,?,?,?)''',
      [title, DateFormat.yMMMd().format(DateTime.now()), priority, description],
    );
  }

  Future<List<Note>> fetchAll() async {
    final database = await DatabaseService().database;
    final notes = await database.rawQuery('''
    SELECT * FROM $noteTable ORDER BY 
      CASE 
        WHEN priority = 'High' THEN 1
        WHEN priority = 'Medium' THEN 2
        WHEN priority = 'Low' THEN 3
        ELSE 4
      END
    ''');
    return notes.map((note) => Note.fromSqfliteDatabase(note)).toList();
  }

  Future<Note> fetchById(int id) async {
    final database = await DatabaseService().database;
    final note = await database.rawQuery('''
    SELECT * FROM $noteTable WHERE id = $id;
    ''');
    return Note.fromSqfliteDatabase(note.first);
  }

  Future<int> update(
      {required int id,
      String? title,
      String? priority,
      String? description}) async {
    final database = await DatabaseService().database;
    return await database.update(
      noteTable,
      {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (priority != null) 'priority': priority,
        'date': DateFormat.yMMMd().format(DateTime.now()),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $noteTable WHERE id = ?''', [id]);
  }
}
