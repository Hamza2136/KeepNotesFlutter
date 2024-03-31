import 'dart:async';
import 'package:flutter/material.dart';
import 'package:keepnotes/models/note.dart';
import 'package:keepnotes/pages/create_note.dart';
import 'package:keepnotes/pages/edit_note.dart';
import 'package:keepnotes/utils/notes_db.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});
  @override
  State<StatefulWidget> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  late Future<List<Note>> futureNotes;
  final notesDb = NotesDb();

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    setState(() {
      futureNotes = notesDb.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: Colors.cyan,
      ),
      body: FutureBuilder<List<Note>>(
        future: futureNotes,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final notes = snapshot.data!; // Using safe access operator
            return notes.isEmpty
                ? const Center(
                    child: Text(
                      'No Notes..',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      final subtitle = note.date.toString();
                      return Card(
                        color: const Color.fromARGB(121, 4, 226, 255),
                        elevation: 1.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: getPriorityColor(note.priority),
                            child: getPriorityIcon(note.priority),
                          ),
                          title: Text(
                            note.title,
                          ),
                          subtitle: Text(subtitle),
                          trailing: IconButton(
                            onPressed: () async {
                              await notesDb.delete(note.id);
                              fetchNotes();
                              _showSnackBar(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  "Note Deleted Successfully");
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditNotePage(
                                  note: note,
                                  onUpdate: () {
                                    fetchNotes();
                                    _showSnackBar(
                                        context, "Note Updated Successfully");
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
          }
          return const Center(child: Text('No data available'));
        }),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Note",
        backgroundColor: Colors.cyan,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNotePage(
                onCreate: () {
                  fetchNotes();
                  _showSnackBar(context, "Note Added Successfully");
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Color getPriorityColor(String priority) {
    Color result;
    switch (priority) {
      case 'High':
        result = Colors.indigoAccent;
        break;
      case 'Medium':
        result = Colors.tealAccent;
        break;
      case 'Low':
        result = Colors.limeAccent;
      default:
        result = Colors.green.shade700;
        break;
    }
    return result;
  }

  Icon getPriorityIcon(String priority) {
    Icon result;
    switch (priority) {
      case 'High':
        result = const Icon(Icons.keyboard_arrow_up_outlined);
        break;
      case 'Medium':
        result = const Icon(Icons.keyboard_arrow_right);
        break;
      case 'Low':
        result = const Icon(Icons.keyboard_arrow_down);
        break;
      default:
        result = const Icon(Icons.keyboard_arrow_down);
        break;
    }
    return result;
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
