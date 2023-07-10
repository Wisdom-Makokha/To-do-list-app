import 'package:flutter/material.dart';
import 'package:to_do_list/Screens/home_screen.dart';
import 'package:to_do_list/Screens/ForgotPassword.dart';
import 'package:to_do_list/Screens/Register.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context){

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