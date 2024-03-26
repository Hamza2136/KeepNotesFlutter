import 'package:flutter/material.dart';
import 'package:keepnotes/app_screens/node_list.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Keep Notes",
      debugShowCheckedModeBanner: false,
      home: NodeList(),
    );
  }
}
