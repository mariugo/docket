import 'package:get/get.dart';

import '/data/local/task_repository.dart';
import '/data/providers/task_provider.dart';
import '/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
