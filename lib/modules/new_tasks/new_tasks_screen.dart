import 'package:flutter/material.dart';
import 'package:udemy2/shared/components/components.dart';
import 'package:udemy2/shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => BuildTaskItem(tasks[index]),
      separatorBuilder: (context, index) => ListSeparator(),
      itemCount: tasks.length,
    );
  }
}
