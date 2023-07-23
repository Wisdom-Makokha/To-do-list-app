import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/Definitions/declarations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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

  List<MyTasks> tasks = [];
  List<MyTasks> inCompletedTasks = [];
  List<MyTasks> completedTasks = [];

  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    initTaskList();
  }

  Future<void> initTaskList() async {
    final List<Map<String, dynamic>> taskList = await toDoListDatabase.query(
        taskTable,
    where: '$taskTBUserIdForeign = ?',
    whereArgs: [myLoginId]);

    tasks = List.generate(taskList.length, (i) =>
        MyTasks(
            taskId: taskList[i]['id'],
            taskName: taskList[i][taskTBName],
            description: taskList[i][taskTBDescription],
            completed: taskList[i][taskTBCompletedFlag] == 1 ? true : false,
            taskUserId: taskList[i][taskTBUserIdForeign])
    );

    for(int i = 0; i < tasks.length; i++){
      if(tasks[i].completed){
        completedTasks.add(tasks[i]);
      } else {
        inCompletedTasks.add(tasks[i]);
      }
    }
    setState(() {
      completedTasks;
      inCompletedTasks;
    });
  }

  Future<int> getId() async {
    final result =
        await toDoListDatabase.rawQuery("SELECT MAX(id) AS id FROM $taskTable");

    int myId;
    if (result.single['id'] == null) {
      myId = 0;
    } else {
      myId = (result.single['id'] as int) + 1;
    }
    return myId;
  }

  Future<void> deleteAll() async {
    print(await toDoListDatabase.delete(taskTable));
  }


  Future<void> viewTable() async{
    print(await toDoListDatabase.query(taskTable));
  }

  Future<void> insertTasks() async {
    var myNewTask = MyTasks(
      taskId: await getId(),
      taskName: taskNameController.text,
      description: descriptionController.text,
      taskUserId: myLoginId,
    );

    setState(() {
      inCompletedTasks.add(myNewTask);
    });

    await toDoListDatabase.insert(taskTable, myNewTask.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    Fluttertoast.showToast(msg: 'Task added successfully');
    screenShiftBack();
  }

  void screenShiftBack(){
    Navigator.pop(context);
  }

  void addTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskNameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Title',
                  hintText: 'Enter the name for your task',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Description',
                  hintText: 'Enter the description for your task',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: insertTasks,
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }

  int numberOfTasks(List<MyTasks> toCount){
    setState(() {
      toCount;
    });

    return toCount.length;
  }

  ///This is a function that returns a text style and takes to values
  ///context and the bool for whether a task is complete or not
  TextStyle getStyle(BuildContext context, bool done) {
    ///This portion returns style for giving text a line through
    if (done) {
      return const TextStyle(
        color: Colors.black26,
        decoration: TextDecoration.lineThrough,
      );
    }
    ///the style here is for normal text
    else {
      return const TextStyle(
        color: Colors.black,
      );
    }
  }

  ///The rest of these functions repeat the above principle but for different things
  ///This function returns Widget icon and checks whether the task is done or not
  Widget getIcon(BuildContext context, bool done) {
    return done ? const Icon(Icons.done) : const Icon(Icons.remove);
  }

  ///This function returns a color and also checks if the task is done
  Color getColor(BuildContext context, bool done) {
    return done ? Theme.of(context).colorScheme.primary
        : Colors.blueGrey;
  }

  Widget buildContainer(BuildContext context, String inText, bool done){
    return Container(
      height: 60,
      width: 300,
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      padding: const EdgeInsets.all(3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
            color: getColor(context, done),
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(10),
            right: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: getColor(context, done),
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
            )
          ]
      ),
      child: Text(
        inText,
        style: Theme.of(context).textTheme.headlineSmall,),
    );
  }

  Widget buildList(BuildContext context, List<MyTasks> firstList,
      List<MyTasks> secondList){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: numberOfTasks(firstList),
      itemBuilder: (context, index) {
        final task = firstList[index];

        Future<void> tapToComplete()async{
          setState(() {
            task.completed = !task.completed;
            secondList.add(task);
            firstList.remove(task);
          });

          await toDoListDatabase.update(
              taskTable,
              task.toMap(),
              where: 'id = ?',
              whereArgs: [task.taskId]);
        }

        return ListTile(
          leading: CircleAvatar(
            ///color is gotten from getColor function
            backgroundColor: getColor(context, task.completed),
            ///icon type is gotten from function
            child: getIcon(context, task.completed),
          ),
          title: Text(
            task.taskName,
            ///Style for text is gotten from getStyle function
            style: getStyle(context, task.completed),
          ),
          subtitle: Text(
            task.description,
            ///Style for text is gotten from getStyle function
            style: getStyle(context, task.completed),
          ),
          ///The onTap portion is the most important for ensuring there is a change
          ///task.completed is turned either true or false affecting everything else
          ///setState is important to ensure flutter actively monitors task.completed
          ///and changes everything it affects accordingly
          onTap: tapToComplete,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildContainer(context, 'Incomplete Tasks', false),
            buildList(context, inCompletedTasks, completedTasks),
            buildContainer(context, 'Complete Tasks', true),
            buildList(context, completedTasks, inCompletedTasks),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addTaskDialog,
        label: const Text('Add task'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).indicatorColor,
          child: Container(
            height: 70,
          )),
    );
  }
}


