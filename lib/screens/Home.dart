import 'package:flutter/material.dart';
import 'package:first_flutter_app/controllers/todo_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

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

    return Scaffold(
        body: const Center(
        child: Text('Home'),
    ),
    );
  }
}