import 'package:flutter/material.dart';
import 'package:to_do_list/screens/login.dart';
import 'package:to_do_list/screens/home_screen.dart';
import 'package:to_do_list/screens/register.dart';
import 'package:to_do_list/screens/forgot_password.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:to_do_list/Definitions/declarations.dart';


void main() async{
  runApp(const ToDoApp());

  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String pathToDB = "${documentsDirectory.path}/users.db";

  toDoListDatabase = await openDatabase(
    pathToDB,
    version: 1,
    onCreate: (Database db, int version) async{
      await db.execute(
        "CREATE TABLE $userTable"
            " (id INT PRIMARY KEY AUTOINCREMENT,"
            "$table1Column1 VARCHAR(54),"
            " $table1Column2 VARCHAR(150),"
            " $table1Column3 VARCHAR(50))"
      );
    }
  );
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List App',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/Home': (context) => const HomeScreen(),
        '/Register': (context) => const RegisterScreen(),
        '/ForgotPass': (context) => const ForgotPassScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
