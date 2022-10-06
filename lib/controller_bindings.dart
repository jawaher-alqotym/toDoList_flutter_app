import 'package:get/instance_manager.dart';
import 'package:first_flutter_app/controllers/todo_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<TodoController>(TodoController());
  }
}