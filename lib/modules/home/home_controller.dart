import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:docket/data/local/task_repository.dart';

import '../../data/model/task.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final tasks = <Task>[].obs;
  final chipIndex = 0.obs;

  HomeController({
    required this.taskRepository,
  });

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }

  void changeChipIndex(int index) {
    chipIndex.value = index;
  }
}
