// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:keepnotes/utils/notes_db.dart';

class CreateNotePage extends StatefulWidget {
  final Function onCreate;

  const CreateNotePage({super.key, required this.onCreate});

  @override
  // ignore: library_private_types_in_public_api
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _priorities = ['Low', 'Medium', 'High'];
  String selectedPriority = 'Low';
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
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
                  value: selectedPriority.isNotEmpty
                      ? selectedPriority
                      : _priorities[0],
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
                      await NotesDb().create(
                          title: _titleController.text,
                          priority: selectedPriority,
                          description: _descriptionController.text);
                      widget.onCreate();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Create Note"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
