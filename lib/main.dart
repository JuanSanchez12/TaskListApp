import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Task List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _TaskListScreen();
}

class _TaskListScreen extends State<MyHomePage> {
void newTask() {
  showDialog(
    context: context,
    builder: (context) {
      return CreateTask(
        onTaskAdded: (taskName) {
          setState(() {
            taskList.add([taskName, false]);
          });
        },
      );
    }
  );
}

  List taskList = [
    ["example1", false],
    ["example2", true],
  ];

  void taskCheckToggle(bool? value, int index) {
    setState(() {
      taskList[index][1] = !taskList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 192, 169, 255),
        title: Text(widget.title),
      ),

      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return TaskListItem(
            taskName: taskList[index][0],
            taskCheck: taskList[index][1],
            onChanged: (value) => taskCheckToggle(value, index),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: newTask,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskListItem extends StatelessWidget {
  final String taskName;
  final bool taskCheck;
  Function(bool?)? onChanged;

  TaskListItem({
    super.key,
    required this.taskName,
    required this.taskCheck,
    required this.onChanged
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 192, 169, 255)),
        child: Row(
          children: [
            Checkbox(value: taskCheck, onChanged: onChanged),
            Text(taskName)
          ],
        ),
      ),
    );
  }
}
class CreateTask extends StatefulWidget {
  final Function(String) onTaskAdded;

  const CreateTask({super.key, required this.onTaskAdded});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 217, 207, 245),
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: "Add new task"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onTaskAdded(_controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
