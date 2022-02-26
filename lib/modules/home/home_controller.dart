import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

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

  void changeTodos(List<dynamic> selectedTodos) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < selectedTodos.length; i++) {
      var todo = selectedTodos[i];
      var isDone = todo['done'];
      if (isDone == 'true') {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTodo(String title) {
    var todo = {
      'title': title,
      'done': false,
    };
    if (doingTodos.any(
      (_element) => mapEquals<String, dynamic>(todo, _element),
    )) {
      return false;
    }

    var doneTodo = {
      'title': title,
      'done': true,
    };

    if (doneTodos
        .any((_element) => mapEquals<String, dynamic>(doneTodo, _element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll(
      [
        ...doingTodos,
        ...doneTodos,
      ],
    );
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
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
