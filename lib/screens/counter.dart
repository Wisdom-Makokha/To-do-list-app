import 'package:flutter/material.dart';


class CounterScreen extends StatefulWidget{
  const CounterScreen ({super.key});

  @override
  State<CounterScreen> createState() => CounterScreenState();
}

class CounterScreenState extends State<CounterScreen>{
  int ourCounter = 0;
  FloatingActionButtonLocation floatLocater =
      FloatingActionButtonLocation.centerFloat;

  bool locatorFlag = true;

  void changeFloatLocation()
  {
    if(locatorFlag)
      {
        floatLocater = FloatingActionButtonLocation.centerDocked;
      }
    else
      {
        floatLocater = FloatingActionButtonLocation.centerFloat;
      }

    locatorFlag = !locatorFlag;
  }
  @override
  Widget build(BuildContext context){

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
          title: const Text('Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You have counted $ourCounter times'),
              ElevatedButton(
                onPressed: () {
                  changeFloatLocation();
                },
                style: elevatedButtonsStyle,
                child: const Text('Boo'),
              ),
            ]
          )

        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.lime,
          child: Container(height: 60.0),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            ourCounter++;
            changeFloatLocation();
          }),
          tooltip: 'Increment Counter',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: floatLocater,
      );
  }
}