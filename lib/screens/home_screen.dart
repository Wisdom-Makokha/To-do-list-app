import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

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
        title: const Text('To do List'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              const Text('Hello',
                  style: TextStyle(
                    color: Colors.lime,
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                  )),
              const Text("Welcome to to the to do list app!",
              style: TextStyle(
                color: Colors.lime,
                fontSize: 18,
                fontStyle: FontStyle.normal,
              )),
              const Image(image: AssetImage('images/'
                  'home_screen_to_do_list.png')),
              ElevatedButton(
                onPressed: null,
                style: elevatedButtonsStyle,
                child: const Text('Your tasks'),
              )
            ],
        ),
      ),
    );
  }

}