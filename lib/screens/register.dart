import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/Definitions/declarations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

final TextEditingController userNameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passCheckController = TextEditingController();

class RegisterScreenState extends State<RegisterScreen> {
  //Function to build and render the snack bar when called
  void mySnackBar(String myText, Color myBackgroundColor) {
    final snackBar = SnackBar(
      content: Text(
        myText,
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

  //Function to get the highest id
  //This is to make the id's in the table to be ordered by ascension
  Future<int> getId() async {
    final result =
        await toDoListDatabase.rawQuery("SELECT MAX(id) AS id FROM $userTable");

    int myId;
    if (result.single['id'] == null) {
      myId = 0;
    } else {
      myId = 1 + (result.single['id'] as int);
    }

    return myId;
  }

  //admin delete
  Future<void> deleteAll() async {
    print(await toDoListDatabase.delete(userTable));
  }

  Future<void> viewTable() async{
    print(await toDoListDatabase.query(userTable));
  }

  void screenShiftToLogin(){
    Navigator.pop(context);
  }

  Future<void> registerMe() async {
    //the text editing controller does nothing (no data is input into any string)
    // when the text field is left empty so we check if the text editing controller
    //itself is empty to tell the user it is empty

    if (userNameController.text.isEmpty) {
      mySnackBar('Username is field empty', Colors.red);
    } else if (emailController.text.isEmpty) {
      mySnackBar('Email field is empty', Colors.red);
    } else if (passwordController.text.isEmpty) {
      mySnackBar('Password field is empty', Colors.red);
    } else if (passCheckController.text.isEmpty) {
      mySnackBar('Confirm password field is empty', Colors.red);
    } else if (passCheckController.text != passwordController.text) {
      mySnackBar('Register failed \nPasswords do not match', Colors.red);
    } else {
      var thisUser = TaskUsers(
        userId: await getId(),
        username: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      await toDoListDatabase.insert(userTable, thisUser.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      mySnackBar('Register successful!', Colors.lime);
      screenShiftToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(
                image: AssetImage('images/register_to_do.png'), width: 300),
            Container(
              padding: textFieldPadding,
              child: Column(
                children: <Widget>[
                  MyTextField(
                    hintText: 'Enter a unique username',
                    labelText: 'Username',
                    controller: userNameController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextField(
                    hintText: 'Enter your email address',
                    labelText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextField(
                    hintText: 'Enter a secure password',
                    labelText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextField(
                    hintText: 'Reenter your password',
                    labelText: 'Confirm password',
                    controller: passCheckController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: registerMe,
              style: elevatedButtonsStyle,
              child: const Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}
