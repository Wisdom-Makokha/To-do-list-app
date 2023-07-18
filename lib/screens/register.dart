import 'package:flutter/material.dart';
import 'package:to_do_list/Definitions/declarations.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen ({super.key});

  @override
  State<RegisterScreen> createState()=> RegisterScreenState();
}

final TextEditingController userNameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passCheckController = TextEditingController();

class RegisterScreenState extends State<RegisterScreen>{
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
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> registerMe() async{
    String nameUser = userNameController.text;
    String addressEmail = emailController.text;
    String password = passwordController.text;
    String passCheck = passCheckController.text;

    if(passCheck == password){
      await toDoListDatabase.insert(userTable,{
        table1Column1: nameUser,
        table1Column2: addressEmail,
        table1Column3: password,}
      );
      mySnackBar('Register successful!', Colors.lime);}
    else{
      mySnackBar('Register failed \nPasswords do not match', Colors.red);}
    }

  void registerNew (){
    registerMe();
    Navigator.pushReplacementNamed(context, '/Login');
  }

  @override
  Widget build(BuildContext context){
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
            Container(
              padding: textFieldPadding,
              child: Column(
                children: <Widget>[
                  MyTextField(
                      hintText: 'Enter a unique username',
                      labelText: 'Username',
                      controller: userNameController,
                  ),
                  const SizedBox(height: 16,),
                  MyTextField(
                    hintText: 'Enter your email address',
                    labelText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 16,),
                  MyTextField(
                    hintText: 'Enter a secure password',
                    labelText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16,),
                  MyTextField(
                    hintText: 'Reenter your password',
                    labelText: 'Confirm password',
                    controller: passCheckController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16,)
                ],
              ),
            ),
            ElevatedButton(
              onPressed: registerNew,
              style: elevatedButtonsStyle,
              child: const Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}