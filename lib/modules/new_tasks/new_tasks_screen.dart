import 'package:flutter/material.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "New Tasks",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
        ),
      ),
    );
  }
}
