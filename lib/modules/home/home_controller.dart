import 'package:get/get.dart';

import 'package:docket/data/local/task_repository.dart';

import '../../data/model/task.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;

  HomeController({
    required this.taskRepository,
  });

  final tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }
}
