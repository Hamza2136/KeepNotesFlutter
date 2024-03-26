import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class NodeDetails extends StatefulWidget {
  const NodeDetails({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NodeDetails();
  }
}

class _NodeDetails extends State<NodeDetails> {
  var priority = ['Low', 'Mid', 'High'];
  var selectedPrioriy = 'Low';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note List"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: DropdownButton<String>(
                      items: priority.map((String dropdownStringItem) {
                        return DropdownMenuItem(
                            value: dropdownStringItem,
                            child: Text(dropdownStringItem));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPrioriy = value.toString();
                        });
                      },
                      value: selectedPrioriy,
                    ),
                  ),
                ),

                //for fun.....
                Container(
                  width: 261,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  label: Text('Title'),
                  hintText: 'What to do ...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  label: Text('Description'),
                  hintText: 'Write Your Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        debugPrint("Button Pressed");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white),
                      child: const Text("Save")),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        debugPrint("Button Pressed");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white),
                      child: const Text("Delete")),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
