import 'package:flutter/material.dart';
import 'package:to_do_list/Screens/Login.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              const Text("Welcome to to the to do list app!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontStyle: FontStyle.normal,
              )),
              const Text('Hello',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 15,
                fontStyle: FontStyle.normal,
              )),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  => const LoginScreen()),);
                },
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                    color: Colors.white38,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                  ),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  shadowColor: Colors.lime,
                ),
                child: const Text('Raised button'),
              )
            ],
        ),
      ),
    );
  }

}