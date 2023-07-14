import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

late Database toDoListDatabase;

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

const String userTable = "users";

const String table1Column1 = 'username';
const String table1Column2 = 'email';
const String table1Column3 = 'password';

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