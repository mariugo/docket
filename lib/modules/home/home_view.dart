import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '/modules/home/home_controller.dart';
import '/core/utils/extensions.dart';
import '/core/values/colors.dart';
import '/data/model/task.dart';
import '/modules/home/widgets/add_card_widget.dart';
import '/modules/home/widgets/add_todo_dialog_widget.dart';
import '/modules/home/widgets/task_card_widget.dart';
import '/modules/report/report_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
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
            const ReportView(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor: controller.isDeleting.value ? Colors.red : blue,
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(
                    () => AddTodoDialogWidget(),
                    transition: Transition.downToUp,
                  );
                } else {
                  EasyLoading.showInfo('Please create a task type');
                }
              },
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
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Padding(
                  padding: EdgeInsets.only(
                    right: 15.0.widthPoints,
                  ),
                  child: const Icon(
                    Icons.apps,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Report',
                icon: Padding(
                  padding: EdgeInsets.only(
                    left: 15.0.widthPoints,
                  ),
                  child: const Icon(
                    Icons.data_usage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
