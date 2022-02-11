import 'package:flutter/material.dart';

class UserModel {
  final int id;
  final String name;
  final String number;

  UserModel({
    required this.id,
    required this.name,
    required this.number,
  });
}

class UsersScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(
      id: 1,
      name: "Malek",
      number: "079123456",
    ),
    UserModel(
      id: 2,
      name: "Ahmad",
      number: "079113136",
    ),
    UserModel(
      id: 3,
      name: "Jack",
      number: "079564456",
    ),
    UserModel(
      id: 4,
      name: "Jade",
      number: "0791646456",
    ),
    UserModel(
      id: 5,
      name: "Lolo",
      number: "079125446",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 2.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildUserItem(UserModel user) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25.0,
            child: Text(
              "${user.id}",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.name}",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  "${user.number}",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
