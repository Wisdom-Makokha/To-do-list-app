import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context){

    const EdgeInsetsGeometry textFieldPadding= EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    )
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Padding(
              padding: textFieldPadding,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a unique user name',
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: textFieldPadding,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  labelText: 'Enter your email address',
                ),
              ),
            ),
            Padding(
              padding: textFieldPadding,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a secure password',
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){},
              child: Text('Register')
            )
          ],
        ),
      ),
    );
  }
}