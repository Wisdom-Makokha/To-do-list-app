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
  List<MyTasks> tasks = [];
  List<MyTasks> inCompletedTasks = [];
  List<MyTasks> completedTasks = [];
  int selectedIndex = 0;

  final taskNameController = TextEditingController();
  //A controller to take the description for the task
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    initTaskList();
  }

  //Function to initialize a list of tasks as obtained from the database
  Future<void> initTaskList() async {
    //task list is a list map containing all the tasks for a specific login id
    final List<Map<String, dynamic>> taskList = await toDoListDatabase.query(
        taskTable,
        where: '$taskTBUserIdForeign = ?',
        whereArgs: [myLoginId]);

    //the list map is converted into a list of classes of my tasks
    tasks = List.generate(
        taskList.length,
        (i) => MyTasks(
            taskId: taskList[i]['id'],
            taskName: taskList[i][taskTBName],
            description: taskList[i][taskTBDescription],
            completed: taskList[i][taskTBCompletedFlag] == 1 ? true : false,
            taskUserId: taskList[i][taskTBUserIdForeign]));

    //tasks is split into two lists, one completed the other in-completed
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].completed) {
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

  //To ensure the ids are sequential this function takes the current
  //largest task id and returns another id increases by one
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

  //Admin delete everything from table
  Future<void> deleteAll() async {
    print(await toDoListDatabase.delete(taskTable));
  }

  //Admin view table in terminal
  Future<void> viewTable() async {
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

  void screenShiftBack() {
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
    return done ? Theme.of(context).colorScheme.tertiary : Colors.blueGrey;
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
        int modifier = 100 * (index % 10);

        return Container(
          margin: const EdgeInsets.only(
            top: 2,
            bottom: 4,
            left: 5,
            right: 5
          ),
          decoration: BoxDecoration(
            color: Color.fromRGBO(240 * modifier, 244, 255, 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
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
          ),
        );
      },
    );
  }

  Widget selectWidget(){
    if(selectedIndex == 0){
      return buildList(context, inCompletedTasks, completedTasks);
    }
      return buildList(context, completedTasks, inCompletedTasks);
  }

  void onIconTapped(index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do List'),
        backgroundColor: selectedIndex == 0 ? getColor(context, false)
        : getColor(context, true),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [selectedIndex == 0 ?
                getColor(context, false)
                    : getColor(context, true),
                  Colors.white38
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              )
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                selectWidget(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addTaskDialog,
        label: const Text('Add task'),
        icon: const Icon(Icons.add),
        backgroundColor: selectedIndex == 0 ? getColor(context, false)
        : getColor(context, true),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white70,
        onTap: onIconTapped,
        currentIndex: selectedIndex,
        backgroundColor: selectedIndex == 0 ? getColor(context, false)
        : getColor(context, true),
        items: [
          BottomNavigationBarItem(
            icon: getIcon(context, false),
            label: 'Incomplete',
          ),
          BottomNavigationBarItem(
            icon: getIcon(context, true),
            label: 'Complete'
          )
        ],
      )
    );
  }
}
