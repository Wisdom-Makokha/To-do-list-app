import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Image(image: AssetImage('Mobile_login.png')),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Username',
                )
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
            ),
            const Text('Forgot Password',
            ),
            ElevatedButton(
              onPressed:(){
                Navigator.pop(context);
              },
              child: const Text('Login'),
            )
          ]
        )
      )
    );
  }

}