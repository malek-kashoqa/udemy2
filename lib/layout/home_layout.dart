import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy2/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy2/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy2/modules/new_tasks/new_tasks_screen.dart';

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

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
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
}

void createDatabase() async {
  var database = openDatabase(
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

void insertToDatabase() {}
