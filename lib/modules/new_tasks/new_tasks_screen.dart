import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy2/shared/components/components.dart';
import 'package:udemy2/shared/components/constants.dart';
import 'package:udemy2/shared/cubit/cubit.dart';
import 'package:udemy2/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) => BuildTaskItem(tasks[index]),
        separatorBuilder: (context, index) => ListSeparator(),
        itemCount: tasks.length,
      ),
    );
  }

}
