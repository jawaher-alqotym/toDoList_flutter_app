import 'package:flutter/material.dart';
import 'package:first_flutter_app/controllers/todo_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();

    return GetBuilder<TodoController>(
        init: TodoController(),
    initState: (_) {},
    builder: (todoController) {
    todoController.getData();

    return Scaffold(
    body: Center(
    child: todoController.isLoading ? const SizedBox(
      child: CircularProgressIndicator(),
    )
        : ListView.builder(
      itemCount: todoController.taskList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Checkbox(
              onChanged: (value) => todoController.addTask(
                  todoController.taskList[index].task_name,
                  !todoController.taskList[index].isDone,
                  todoController.taskList[index].id),
              value: todoController.taskList[index].isDone),
          title: Text(todoController.taskList[index].task_name),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                onPressed: () => addTaskDialog(
              todoController,
              'Update Task',
              todoController.taskList[index].id,
              todoController.taskList[index].task_name),
                  icon: const Icon(Icons.edit),
        ),
              IconButton(
                 onPressed: () => todoController.deleteTask(
                 todoController.taskList[index].id),
                 icon: const Icon(Icons.delete),
                 color: Colors.amberAccent,
        ),
        ],
        ),
        ),
        );
      },
    ),
    ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_task),
        onPressed: () async =>
        await addTaskDialog(todoController, 'Add Todo', '', ''),
      ),
    );
    },
    );
  }

  addTaskDialog(TodoController todoController, String title, String id,
      String task) async {
    if (task.isNotEmpty) {
      _taskController.text = task;
    }

    Get.defaultDialog(
      title: title,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _taskController,
            ),
            ElevatedButton(
              onPressed: () async {
                await todoController.addTask(
                    _taskController.text.trim(), false, id);

                _taskController.clear();
                Get.back();
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}