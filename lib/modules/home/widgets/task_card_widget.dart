import 'package:docket/modules/detail/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '/data/model/task.dart';
import '/modules/home/home_controller.dart';
import 'package:docket/core/utils/extensions.dart';

class TaskCardWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final Task task;

  TaskCardWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 12.0.widthPoints;
    final color = HexColor.fromHex(task.color);
    return GestureDetector(
      onTap: () {
        homeController.changeTask(task);
        homeController.changeTodos(task.todos ?? []);
        Get.to(
          () => DetailView(),
          transition: Transition.circularReveal,
        );
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.widthPoints),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps:
                  homeController.isTodosEmpty(task) ? 1 : task.todos!.length,
              currentStep: homeController.isTodosEmpty(task)
                  ? 0
                  : homeController.getTotalDoneTodos(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  color.withOpacity(0.5),
                  color,
                ],
              ),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.widthPoints),
              child: Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.widthPoints),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.0.widthPoints,
                  ),
                  Text(
                    '${task.todos?.length ?? 0} Task',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
