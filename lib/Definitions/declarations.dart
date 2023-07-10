import 'package:flutter/material.dart';

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
