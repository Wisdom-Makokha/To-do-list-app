import 'package:flutter/material.dart';
import 'package:to_do_list/Screens/Login.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: const LoginScreen(),

    );
  }
}
