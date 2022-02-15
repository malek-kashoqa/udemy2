import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy2/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy2/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy2/modules/new_tasks/new_tasks_screen.dart';
import 'package:udemy2/shared/components/components.dart';
import 'package:udemy2/shared/components/constants.dart';
import 'package:udemy2/shared/cubit/cubit.dart';
import 'package:udemy2/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  late TextEditingController titleController = TextEditingController();
  late TextEditingController timeController = TextEditingController();
  late TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DefaultFormField(
                                      controller: titleController,
                                      prefixIcon: Icon(Icons.title),
                                      keyboardType: TextInputType.text,
                                      text: 'Task Title',
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'The title must not be empty';
                                        }
                                      }),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  DefaultFormField(
                                      controller: timeController,
                                      prefixIcon:
                                          Icon(Icons.watch_later_outlined),
                                      keyboardType: TextInputType.none,
                                      text: 'Task Time',
                                      isReadOnly: true,
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeController.text =
                                              value!.format(context).toString();
                                          print(value.format(context));
                                        });
                                      },
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'The time must not be empty';
                                        }
                                      }),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  DefaultFormField(
                                      controller: dateController,
                                      prefixIcon: Icon(Icons.calendar_today),
                                      keyboardType: TextInputType.none,
                                      text: 'Task Date',
                                      isReadOnly: true,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse('2022-03-01'),
                                        ).then((value) {
                                          print(DateFormat.yMMMd()
                                              .format(value!));
                                          dateController.text =
                                              DateFormat.yMMMd().format(value);
                                        });
                                      },
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'The date must not be empty';
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                        cubit.showBottomSheet(
                          showBottomSheet: false,
                          icon: Icon(Icons.edit),
                        );
                  });
                  cubit.showBottomSheet(showBottomSheet: true, icon: Icon(Icons.add),);
                }
              },
              child: cubit.fapIcon,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    label: 'Tasks',
                    icon: Icon(
                      Icons.menu,
                    )),
                BottomNavigationBarItem(
                    label: 'Done',
                    icon: Icon(
                      Icons.check_circle_outline,
                    )),
                BottomNavigationBarItem(
                    label: 'Archived',
                    icon: Icon(
                      Icons.archive_outlined,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }


}
