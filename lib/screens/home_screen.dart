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

    setState(() {
      tasks = List.generate(taskList.length, (i) =>
          MyTasks(
          taskId: taskList[i]['id'],
          taskName: taskList[i][taskTBName],
          description: taskList[i][taskTBDescription],
          completed: taskList[i][taskTBCompletedFlag],
          taskUserId: taskList[i][taskTBUserIdForeign])
      );
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
      tasks.add(myNewTask);
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

  int numberOfTasks(){
    setState(() {
      tasks;
    });

    return tasks.length;
  }

  Widget getIcon(BuildContext context, bool done) {
    return done ? const Icon(Icons.done) : const Icon(Icons.remove);
  }

  TextStyle getStyle(BuildContext context, bool done) {
    if (done) {
      return const TextStyle(
        color: Colors.black26,
        decoration: TextDecoration.lineThrough,
      );
    } else {
      return const TextStyle(
        color: Colors.black,
      );
    }
  }

  Color getColor(BuildContext context, bool done) {
    return done ? Colors.lime : Colors.purple;
  }

  Widget buildList(BuildContext context){
    return ListView.builder(
      itemCount: numberOfTasks(),
      itemBuilder: (context, index) {
        final task = tasks[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: getColor(context, task.completed),
            child: getIcon(context, task.completed),
          ),
          title: Text(task.taskName),
          subtitle: Text(
            task.description,
            style: getStyle(context, task.completed),
          ),
          onTap: () {
            setState(() {
              task.completed = !task.completed;
            });
          },
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
      body: buildList(context),
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


