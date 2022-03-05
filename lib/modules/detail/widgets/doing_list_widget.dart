import 'package:docket/core/utils/extensions.dart';
import 'package:docket/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoingListWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoingListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.doingTodos.isEmpty &&
              homeController.doneTodos.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/task.png',
                  fit: BoxFit.cover,
                  width: 60.0.widthPoints,
                ),
                Text(
                  'Add task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0.sp,
                  ),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeController.doingTodos
                    .map(
                      (todo) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 3.0.widthPoints,
                          horizontal: 9.0.widthPoints,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 2.0.widthPoints,
                              height: 2.0.widthPoints,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                  (_) => Colors.grey,
                                ),
                                value: todo['done'],
                                onChanged: (value) {
                                  homeController.doneTodo(todo['title']);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.0.widthPoints,
                              ),
                              child: Text(
                                todo['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                if (homeController.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0.widthPoints,
                    ),
                    child: const Divider(
                      thickness: 2,
                    ),
                  ),
              ],
            ),
    );
  }
}
