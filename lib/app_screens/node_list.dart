import 'package:flutter/material.dart';

class NodeList extends StatefulWidget {
  const NodeList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NodeList();
  }
}

class _NodeList extends State<NodeList> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: const Color.fromARGB(255, 144, 96, 227),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB Clicked");
        },
        tooltip: "Add new Note",
        child: const Icon(Icons.add),
      ),
      body: getNodeList(),
    );
  }

  ListView getNodeList() {
    return ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, position) {
          return Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Card(
                color: Colors.white,
                elevation: 3.0,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
                  title: const Text("Text Dummy"),
                  subtitle: const Text("Subtitile Dummy"),
                  trailing: const Icon(Icons.delete, color: Colors.grey),
                  onTap: () {
                    debugPrint("Note Clicked");
                  },
                ),
              ));
        });
  }
}
