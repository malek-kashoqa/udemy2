import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy2/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy2/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy2/modules/new_tasks/new_tasks_screen.dart';
import 'package:udemy2/shared/components/constants.dart';
import 'package:udemy2/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;
  int currentIndex = 0;
  bool isBottomSheetShown = false;
  Icon fapIcon = Icon(Icons.edit);

  void showBottomSheet ({required bool showBottomSheet, required Icon icon}){
    isBottomSheetShown = showBottomSheet;
    fapIcon = icon;
    emit(AppChangeBottomSheetState());
  }

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

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
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
              emit(AppCreateDatabaseState());
          print("Table created");
        }).catchError((error) {
          print("Error when creating the table: ${error.toString()}");
        });
      },
      onOpen: (database) {
        print("DataBase Opened");
        getDataFromDatabase(database).then((value) {
          emit(AppGetDatabaseState());
          tasks = value;
          // print(tasks);
        });
      },
    );
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  })  {
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
    database.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "New")')
          .then((value) {
        print("Raw ${value.toString()} inserted successfully");
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database).then((value) {
          emit(AppGetDatabaseState());
          tasks = value;
          // print(tasks);
        });
      }).catchError((error) {
        print("Error inserting a new raw, error: ${error.toString()}");
      });
    });
  }

  // void addNewTask(Transaction txn) {
  //   txn
  //       .rawInsert(
  //           'INSERT INTO tasks(title, date, time, status) VALUES("Task 1", "1234", "12:12", "New")')
  //       .then((value) {
  //     print("Raw ${value.toString()} inserted successfully");
  //   }).catchError((error) {
  //     print("Error inserting a new raw, error: ${error.toString()}");
  //   });
  // }

  Future<List<Map>> getDataFromDatabase(database) async {
    emit(AppGetDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM tasks');
  }



}
