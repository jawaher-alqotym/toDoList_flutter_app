import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:first_flutter_app/models/task_model.dart';
//import 'package:firebase_database/firebase_database.dart';

class TodoController extends GetxController {
  var isLoading = false;
  var taskList = <TaskModel>[];

  Future<void> addTask(String task_name, bool done, String id) async {
    await FirebaseFirestore.instance
        .collection('ToDo')
        .doc(id != '' ? id : null)
        .set(
      {
        'task_name': task_name,
        'isDone': done,
      },
      SetOptions(merge: true),
    ).then(
          (value) => getData(),
    );
  }

  Future<void> getData() async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('ToDo')
          .orderBy('task_name')
          .get();

      taskList.clear();

      for (var item in _taskSnap.docs) {
        taskList.add(
          TaskModel(item.id, item['task_name'], item['isDone']),
        );
      }
      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteTask(String id) {
    FirebaseFirestore.instance.collection('ToDo').doc(id).delete();
  }
}