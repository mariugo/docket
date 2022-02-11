import '/data/providers/task_provider.dart';
import '/data/model/task.dart';

class TaskRepository {
  final TaskProvider taskProvider;

  TaskRepository({
    required this.taskProvider,
  });

  List<Task> readTasks() => taskProvider.readTasks();

  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
