import 'package:get/get.dart';

import 'package:docket/data/local/task_repository.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;

  HomeController({
    required this.taskRepository,
  });
}
