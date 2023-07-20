import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

/// This is important for the task implementation
/// SELECT MAX(column_name) FROM table_name;
/// It will help with making the next largest id
///
///Variables and classes
late Database toDoListDatabase;
late int myLoginId;

class TaskUsers{
  const TaskUsers({
    required this.userId,
    required this.username,
    required this.email,
    required this.password
  });

  final int userId;
  final String username;
  final String email;
  final String password;

  Map<String, dynamic> toMap(){
    return{
      'id': userId,
      userTBUsername: username,
      userTBEmail: email,
      userTBPassword: password,
    };
  }
}

class MyTasks{
  MyTasks({
    required this.taskId,
    required this.taskName,
    required this.description,
    this.completed = false,
    this.taskUserId = 0,
  });

  final int taskId;
  final String taskName;
  final String description;
  bool completed;
  final int taskUserId;

  Map<String, dynamic> toMap(){
    return{
      'id': taskId,
      taskTBName: taskName,
      taskTBDescription: description,
      taskTBCompletedFlag: completed ? true : false,
      taskTBUserIdForeign: taskUserId,
    };
  }
}
///
///
///
///Reused properties
//Elevated button style defined here for reuse
final ButtonStyle elevatedButtonsStyle = ElevatedButton.styleFrom(
  side: const BorderSide(
    color: Colors.black,
    width: 2,
  ),
  shadowColor: Colors.lime,
  textStyle: const TextStyle(
    fontSize: 20,
    fontStyle: FontStyle.normal,
  ),
);

//Values for the padding of TextField
const EdgeInsetsGeometry textFieldPadding= EdgeInsets.symmetric(
  horizontal: 10,
  vertical: 10,
);
///
///
///
///Reused Widgets
//class to create a TextField whenever it is required
class MyTextField extends StatelessWidget{
  const MyTextField({
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    super.key});

  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  @override

  Widget build(BuildContext context){
    return TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        )
    );
  }
}
///
///
///
/// Database table definitions
const String userTable = "users";

const String userTBUsername = 'username';
const String userTBEmail = 'email';
const String userTBPassword = 'password';

const String taskTable = "tasks";

const String taskTBName = 'title';
const String taskTBDescription = 'description';
const String taskTBCompletedFlag = 'complete';
const String taskTBUserIdForeign = 'userID';


