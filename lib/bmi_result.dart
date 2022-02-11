import 'package:flutter/material.dart';

class bmiResult extends StatelessWidget {
  late int age;
  late int result;
  late bool gender;

  bmiResult({
    required this.result,
    required this.age,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(gender ? "Gender: Male" : "Gender: Female"),
            Text("Result: $result"),
            Text("Age: $age"),
          ],
        ),
      ),
    );
  }
}
