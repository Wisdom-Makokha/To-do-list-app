import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
     return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),
      ),
      body: const Center(
        child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Text('Hello',
                  style: TextStyle(
                    color: Color(0xFF648c11),
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                  )),
              Text("Welcome to to the to do list app!",
              style: TextStyle(
                color: Colors.lime,
                fontSize: 18,
                fontStyle: FontStyle.normal,
              )),
              Image(image: AssetImage('images/'
                  'home_screen_to_do_list.png')),
            ],
        ),
      ),
    );
  }

}