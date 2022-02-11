import 'package:flutter/material.dart';
import 'package:udemy2/modules/home/home_screen.dart';
import 'package:udemy2/modules/login/login_screen.dart';
import 'package:udemy2/modules/bmi/bmi_screen.dart';
import 'package:udemy2/modules/users/users_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: bmiScreen(),
    );
  }
}
