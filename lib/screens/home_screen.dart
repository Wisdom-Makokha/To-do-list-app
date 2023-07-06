import 'package:flutter/material.dart';

class homescreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),

      ),
      body: const Center(
        child: Text('Welcome to the Todo List App!'),
      ),
    );
  }

}