import 'package:flutter/material.dart';
import 'package:to_do_list/Definitions/declarations.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState()=> HomeScreenState();
}


class HomeScreenState extends State<HomeScreen>{
  List tasks = [];

  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState(){
    super.initState();

    initTaskList();
  }

  Future<void> initTaskList()async {
    final List<Map<String, dynamic>> taskList = await toDoListDatabase.query(
      taskTable,
      where: '$taskTBUserIdForeign = ?',
      whereArgs: [myLoginId]);

    setState((){
      tasks = List.generate(taskList.length, (i){
        return MyTasks(
            taskId: taskList[i]['id'],
            taskName: taskList[i][taskTBName],
            description: taskList[i][taskTBDescription],
            completed: taskList[i][taskTBCompletedFlag],
            taskUserId: taskList[i][taskTBUserIdForeign]
        );
      });
    });
  }

  Future<int> getId()async{
    final result = await toDoListDatabase.rawQuery(
      "SELECT MAX(id) AS id FROM $taskTable"
    );

    int myId = result.isNotEmpty ? int.parse(result.single['id'].toString()) : 1;

    return myId++;
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

  Future<void> insertTasks(MyTasks myNewTask)async{
    myNewTask = MyTasks(
      taskId: await getId(),
      taskName: taskNameController.text,
      description: descriptionController.text,
      taskUserId: myLoginId,
    );

    await toDoListDatabase.insert(
      taskTable,
      myNewTask.toMap()
    );

    mySnackBar('Task added', Colors.lime);
  }

  Widget getIcon(BuildContext context, bool done){
    if(done){
      return const Icon(Icons.done);
    } else {
      return const Icon(Icons.remove);
    }
  }

  TextStyle getStyle(BuildContext context, bool done){
    if(done){
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

  Color getColor(BuildContext context, bool done){
    return done ? Colors.lime : Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index){
              final task = tasks[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: getColor(context, task.completed),
                    child: getIcon(context, task.completed),
                  ),
                  title: Text(task.taskName),
                  subtitle: Expanded(
                    child: Text(task.description,
                    style: getStyle(context, task.completed),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).indicatorColor,
        child: Container(height: 70,)
      ),
    );
  }
}