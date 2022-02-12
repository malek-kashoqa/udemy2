import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy2/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy2/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy2/modules/new_tasks/new_tasks_screen.dart';
import 'package:udemy2/shared/components/components.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];

  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  Icon fapIcon = Icon(Icons.edit);
  late TextEditingController titleController = TextEditingController();
  late TextEditingController timeController = TextEditingController();
  late TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context);
              isBottomSheetShown = false;
              setState(() {
                fapIcon = Icon(Icons.edit);
              });
            }
          } else {
            scaffoldKey.currentState?.showBottomSheet((context) => Container(
                  color: Colors.grey[200],
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
                              prefixIcon: Icon(Icons.watch_later_outlined),
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
                                  lastDate: DateTime.parse('2022-03-01'),
                                ).then((value) {
                                  print(DateFormat.yMMMd().format(value!));
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
                ));
            isBottomSheetShown = true;
            setState(() {
              fapIcon = Icon(Icons.add);
            });
          }
        },
        child: fapIcon,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
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
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print("DataBase Created");
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print("Table created");
        }).catchError((error) {
          print("Error when creating the table: ${error.toString()}");
        });
      },
      onOpen: (database) {
        print("DataBase Opened");
      },
    );
  }

  void insertToDatabase() {
    // database.transaction((txn) async {
    //   txn
    //       .rawInsert(
    //           'INSERT INTO tasks(title, date, time, status) VALUES("Task 1", "1234", "12:12", "New")')
    //       .then((value) {
    //     print("Raw ${value.toString()} inserted successfully");
    //   }).catchError((error) {
    //     print("Error inserting a new raw, error: ${error.toString()}");
    //   });
    // });
    database.transaction((txn) async => addNewTask(txn));
  }

  void addNewTask(Transaction txn) {
    txn
        .rawInsert(
            'INSERT INTO tasks(title, date, time, status) VALUES("Task 1", "1234", "12:12", "New")')
        .then((value) {
      print("Raw ${value.toString()} inserted successfully");
    }).catchError((error) {
      print("Error inserting a new raw, error: ${error.toString()}");
    });
  }
}
