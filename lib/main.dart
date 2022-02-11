import 'package:flutter/material.dart';
import 'package:udemy2/home_screen.dart';
import 'package:udemy2/login_screen.dart';
import 'package:udemy2/bmi_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
