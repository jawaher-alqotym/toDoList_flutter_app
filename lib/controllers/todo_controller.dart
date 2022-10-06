import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TodoController extends GetxController {
  Future<void> addTodo(String task_name, bool done) async {
    await FirebaseFirestore.instance.collection('toDo_list').doc().set(
      {
        'task': task_name,
        'isDone': done,
      },
      SetOptions(merge: true),
    ).then(
          (value) => Get.back(),
    );
  }
}