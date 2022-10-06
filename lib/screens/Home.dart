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
          backgroundColor: Color(0xff404652),
          appBar: AppBar(
            bottomOpacity: 0.0,
            elevation: 0.0,
          ),
          body: Center(
            child: todoController.isLoading
                ? const SizedBox(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: todoController.taskList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top:25.0),
                        child: SizedBox(
                          height: 150.0,
                          child: Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color(0xff272c33),
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: ListTile(
                                leading: Checkbox(
                                    shape: CircleBorder(),
                                    onChanged: (value) => todoController.addTask(
                                        todoController.taskList[index].task_name,
                                        !todoController.taskList[index].isDone,
                                        todoController.taskList[index].id),
                                    value: todoController.taskList[index].isDone),
                                title: Text(
                                  todoController.taskList[index].task_name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                trailing: SizedBox(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () => addTaskDialog(
                                              todoController,
                                              'Update Task',
                                              todoController.taskList[index].id,
                                              todoController
                                                  .taskList[index].task_name),
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 25.0,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () => todoController
                                              .deleteTask(todoController
                                                  .taskList[index].id),
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 25.0,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            child: const Icon(Icons.add_task, ),
            onPressed: () async =>
                await addTaskDialog(todoController, 'TASK', '', ''),
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
      content: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _taskController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await todoController.addTask(
                        _taskController.text.trim(), false, id);

                    _taskController.clear();
                    Get.back();
                  },
                  child: Text("save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
