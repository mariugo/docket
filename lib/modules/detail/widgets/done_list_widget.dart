import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/utils/extensions.dart';
import '/core/values/colors.dart';
import '/modules/home/home_controller.dart';

class DoneListWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoneListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.0.widthPoints,
                    horizontal: 5.0.widthPoints,
                  ),
                  child: Text(
                    'Completed (${homeController.doneTodos.length}) todos',
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ...homeController.doneTodos
                    .map((todo) => Dismissible(
                          key: ObjectKey(todo),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (_) =>
                              homeController.deleteDonetodo(todo),
                          background: Container(
                            color: Colors.red.withOpacity(0.8),
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 5.0.widthPoints,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3.0.widthPoints,
                              horizontal: 9.0.widthPoints,
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Icons.done,
                                    color: blue,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.0.widthPoints,
                                  ),
                                  child: Text(
                                    todo['title'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ],
            )
          : Container(),
    );
  }
}
