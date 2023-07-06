import 'package:flutter/material.dart';
import 'package:to_do_list/screens/home_screen.dart';

void main() {
  runApp(const todo_app());
}

class todo_app extends StatelessWidget {
  const todo_app({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: homescreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
