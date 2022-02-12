import 'package:flutter/material.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Archived Tasks",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
        ),
      ),
    );
  }
}
