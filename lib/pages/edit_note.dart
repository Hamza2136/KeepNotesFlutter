import 'package:flutter/material.dart';
import 'package:keepnotes/models/note.dart';
import 'package:keepnotes/utils/notes_db.dart';

class EditNotePage extends StatefulWidget {
  final Note note;
  final Function onUpdate;

  const EditNotePage({super.key, required this.note, required this.onUpdate});

  @override
  // ignore: library_private_types_in_public_api
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String selectedPriority = '';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descriptionController =
        TextEditingController(text: widget.note.description);
    selectedPriority = widget.note.priority;
  }

  final List<String> _priorities = ['Low', 'Medium', 'High'];
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(),
                child: DropdownButton<String>(
                  items: _priorities.map((String dropdownStringItem) {
                    return DropdownMenuItem(
                      value: dropdownStringItem,
                      child: Text(dropdownStringItem),
                    );
                  }).toList(),
                  value: selectedPriority.isNotEmpty ? selectedPriority : "Low",
                  onChanged: (value) {
                    setState(() {
                      selectedPriority = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  controller: _titleController,
                  validator: (value) => value != null && value.isEmpty
                      ? 'Title is Required'
                      : null,
                  decoration: InputDecoration(
                    label: const Text('Title'),
                    hintText: 'What to do ...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  controller: _descriptionController,
                  validator: (value) => value != null && value.isEmpty
                      ? 'Description is Required'
                      : null,
                  decoration: InputDecoration(
                    label: const Text('Description'),
                    hintText: 'Details of note...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.white),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      await NotesDb().update(
                        id: widget.note.id,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        priority: selectedPriority,
                      );
                      widget.onUpdate();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Update Note"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
