import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:docket/data/local/task_repository.dart';

import '../../data/model/task.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final chipIndex = 0.obs;
  final isDeleting = false.obs;

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

  void changeDeleting(bool value) {
    isDeleting.value = value;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeTask(Task? selectTask) {
    task.value = selectTask;
  }

  void changeChipIndex(int index) {
    chipIndex.value = index;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  bool updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containsTodo(todos, title)) {
      return false;
    }
    var todo = {
      'title': title,
      'done': false,
    };
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTask;
    tasks.refresh();
    return true;
  }

  bool containsTodo(List todos, String title) {
    return todos.any(
      (_todo) => _todo['title'] == title,
    );
  }
}
