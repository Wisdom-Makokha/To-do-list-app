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

  void screenShiftTo(String newRoute){
    Navigator.pushReplacementNamed(context, '/$newRoute');
  }

  void mySnackBar(String myText, Color myBackgroundColor)
  {
    final snackBar = SnackBar(
      content: Text(myText,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: myBackgroundColor,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

    List<Map<String, dynamic>> users = await toDoListDatabase.query(
        userTable,
        where: '$userTBUsername = ? AND $userTBPassword = ?',
        whereArgs: [userName,password]
    );

    if(users.isNotEmpty){
      //Login successful
      //Perform necessary actions (e.g navigate to another screen)
      screenShiftTo('Home');
      myLoginId = int.parse(users.single['id'].toString());
      print(myLoginId);

      mySnackBar('Login successful!', Colors.lime);
      } else {
      //Login failed
      mySnackBar('Login Failed!', Colors.red);
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
              child: const Image(
                image: AssetImage('images/mobile_login_png.png'
              ),
                width: 300,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed:(){
                    Navigator.pushNamed(context, '/Register');
                  },
                  child: const Text('Register',
                      style: TextStyle(
                        color: Colors.blue,
                      )),
                ),
              ],
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
              onPressed: (){
                Navigator.pushNamed(context, '/ForgotPass');
              },
              child:const  Text('Forgot password?',
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