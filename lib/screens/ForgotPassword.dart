import 'package:flutter/material.dart';

class ForgotPassScreen extends StatelessWidget{
  const ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context){
    //ELevated button style defined here for reuse
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
        title: const Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(image: AssetImage('images/forgot_password.png')),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter your email address to reset your password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed:(){ },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.black,
                  width: 2,
                )
              ),
              child: const Text('Reset Password'),
            ),
          ],
        )
      )
    );
  }
}