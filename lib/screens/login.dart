import 'package:flutter/material.dart';

import 'package:to_do_list/Definitions/declarations.dart';



class LoginScreen extends StatefulWidget{
  const LoginScreen ({super.key});

  @override
  State<LoginScreen> createState()=> LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState(){
    super.initState();

    //Initialise the animation controller
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    //Set up the animation
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    //Defines the animation curve

    //Starts the animation
    animationController.repeat(reverse: true);
    //Repeats the animation continuously in a reverse manner
  }

  @override
  void dispose(){
    animationController.dispose();
    super.dispose();
  }
  //Cleans up resources when the widget is removed from the tree

  Future<void> _login() async{
    String userName = usernameController.text;
    String password = passwordController.text;
    //Retrieves the email and password entered by the user

    List<Map<String, dynamic>> users = await toDoListDatabase.rawQuery(
      "SELECT * FROM $userTable WHERE $table1Column1 = '$userName' "
          "AND $table1Column3 = '$password'"
    );

    if(users.isNotEmpty){
      //Login successful
      //Perform necessary actions (e.g navigate to another screen)
      Navigator.pushNamed(context, '/Home');

      const snackBar = SnackBar(
        content: Text('Login successful!',
        style: TextStyle(
            color: Colors.black,
        ),
      ),
        backgroundColor: Colors.lime,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
      //Login failed
      print("Login failed");
    }
  }

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
            FadeTransition(
              opacity: animation,
              child: const Image(image: AssetImage('images/mobile_login_png.png'),
                width: 300,),
            ),
            Container(
              padding: textFieldPadding,
              child: Column(
                children: <Widget>[
                  MyTextField(
                    hintText: 'Enter your username',
                    labelText: 'Username',
                    controller: usernameController,
                  ),
                  const SizedBox(height: 16,),
                  MyTextField(
                    hintText: 'Enter your secure password',
                    labelText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
            TextButton(
                onPressed:(){
                  Navigator.pushReplacementNamed(context, '/Home');
                },
                child: const Text('Forgot password',
                    style: TextStyle(
                      color: Colors.blue,
                    )),
            ),
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, '/Register');
              },
              child:const  Text('Not yet registered?\nRegister now.',
              style: TextStyle(
                color: Colors.blue,
              ),
              textAlign: TextAlign.center
              )
            ),
            ElevatedButton(
              onPressed: _login,
              style: elevatedButtonsStyle,
              child: const Text('Login'),
            )
          ]
        )
      )
    );
  }

}