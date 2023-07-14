import 'package:flutter/material.dart';
import 'package:to_do_list/definitions/declarations.dart';

class ForgotPassScreen extends StatelessWidget{
  const ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(image: const AssetImage('images/forgot_password.png'),
            width: MediaQuery.of(context).size.width,),
            const Padding(
              padding: textFieldPadding,
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
              style: elevatedButtonsStyle,
              child: const Text('Reset Password'),
            ),
          ],
        )
      )
    );
  }
}