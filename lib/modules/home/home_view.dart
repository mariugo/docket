import 'package:docket/core/values/colors.dart';
import 'package:docket/data/model/task.dart';
import 'package:docket/modules/home/widgets/add_card_widget.dart';
import 'package:docket/modules/home/widgets/task_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '/modules/home/home_controller.dart';
import '/core/utils/extensions.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'My List',
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.tasks
                      .map((_task) => LongPressDraggable(
                          data: _task,
                          onDragStarted: () => controller.changeDeleting(
                                true,
                              ),
                          onDraggableCanceled: (_, __) =>
                              controller.changeDeleting(
                                false,
                              ),
                          onDragEnd: (_) => controller.changeDeleting(
                                false,
                              ),
                          feedback: const Opacity(
                            opacity: 0.8,
                          ),
                          child: TaskCardWidget(task: _task)))
                      .toList(),
                  AddCardWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor: controller.isDeleting.value ? Colors.red : blue,
              onPressed: () {},
              child: Icon(
                controller.isDeleting.value ? Icons.delete : Icons.add,
              ),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Task deleted');
        },
      ),
    );
  }
}
