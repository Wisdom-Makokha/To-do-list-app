import 'package:flutter/material.dart';
import 'package:to_do_list/screens/Login.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context){

    //Values for the padding of TextField
    const EdgeInsetsGeometry textFieldPadding= EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    );

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            const Image(image: AssetImage('images/register_to_do.png'),
            width: 300),
            const Padding(
              padding: textFieldPadding,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a unique user name',
                  labelText: 'Username',
                ),
              ),
            ),
            const Padding(
              padding: textFieldPadding,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  labelText: 'Enter your email address',
                ),
              ),
            ),
            const Padding(
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
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => const LoginScreen()),);
              },
              style: elevatedButtonsStyle,
              child: const Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}