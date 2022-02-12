import 'package:flutter/material.dart';
import 'package:udemy2/modules/login/login_screen.dart';
import 'package:udemy2/modules/bmi/bmi_screen.dart';
import 'package:udemy2/modules/users/users_screen.dart';
import 'package:udemy2/shared/components/components.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myHome(),
    );
  }
}

class myHome extends StatelessWidget {
  const myHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DefaultButton(
              isUpperCase: false,
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => loginScreen(),
                  ),
                );
              },
              text: "loginScreen",
            ),
            SizedBox(
              height: 20.0,
            ),
            DefaultButton(
              isUpperCase: false,
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => bmiScreen(),
                  ),
                );
              },
              text: "bmiScreen",
            ),
            SizedBox(
              height: 20.0,
            ),
            DefaultButton(
              isUpperCase: false,
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsersScreen(),
                  ),
                );
              },
              text: "UsersScreen",
            ),
          ],
        ),
      ),
    );
  }
}
