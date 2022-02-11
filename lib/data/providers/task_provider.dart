import 'dart:convert';
import 'package:get/get.dart';

import '/data/local/data_store_service.dart';
import '/core/values/keys.dart';
import '/data/model/task.dart';

class TaskProvider {
  final _dataStoreService = Get.find<DataStoreService>();

  void writeTasks(List<Task> tasks) {
    _dataStoreService.write(taskKey, jsonEncode(tasks));
  }

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_dataStoreService.read(taskKey).toString())
        .forEach((task) => tasks.add(Task.fromJson(task)));
    return tasks;
  }
}
