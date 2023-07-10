import 'package:flutter/material.dart';
import 'package:to_do_list/Screens/home_screen.dart';
import 'package:to_do_list/Screens/forgotpassword.dart';
import 'package:to_do_list/Screens/register.dart';
import 'package:to_do_list/definitions/declarations.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            const Image(image: AssetImage('images/mobile_login_png.png'),
            width: 300,),
            const Padding(
              padding: textFieldPadding,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Enter your registered name',
                )
              ),
            ),
            const Padding(
              padding: textFieldPadding,
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your secure password',
                ),
              ),
            ),
            TextButton(
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  => const ForgotPassScreen()),);
                },
                child: const Text('Forgot password',
                    style: TextStyle(
                      color: Colors.blue,
                    )),
            ),
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => const RegisterScreen()),);
              },
              child:const  Text('Not yet registered?\nRegister now.',
              style: TextStyle(
                color: Colors.blue,
              ),
              textAlign: TextAlign.center
              )
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => const HomeScreen()),);
              },
              style: elevatedButtonsStyle,
              child: const Text('Login'),
            )
          ]
        )
      )
    );
  }

}