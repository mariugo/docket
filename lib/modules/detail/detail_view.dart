import 'package:docket/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:docket/modules/home/home_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailView extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  DetailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = homeController.task.value!;
    final iconColor = HexColor.fromHex(task.color);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: homeController.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.widthPoints),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeController.updateTodos();
                        homeController.changeTask(null);
                        homeController.editController.clear();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.widthPoints),
                child: Row(
                  children: [
                    Icon(
                      IconData(
                        task.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: iconColor,
                    ),
                    SizedBox(
                      width: 3.0.widthPoints,
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                (() {
                  var totalTodos = homeController.doingTodos.length +
                      homeController.doneTodos.length;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 16.0.widthPoints,
                      top: 3.0.widthPoints,
                      right: 16.0.widthPoints,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '$totalTodos Tasks',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                          ),
                        ),
                        SizedBox(
                          width: 3.0.widthPoints,
                        ),
                        Expanded(
                          child: StepProgressIndicator(
                            totalSteps: totalTodos == 0 ? 1 : totalTodos,
                            currentStep: homeController.doneTodos.length,
                            size: 5,
                            padding: 0,
                            selectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                iconColor.withOpacity(0.5),
                                iconColor,
                              ],
                            ),
                            unselectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey[300]!,
                                Colors.grey[300]!,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.0.widthPoints,
                  horizontal: 5.0.widthPoints,
                ),
                child: TextFormField(
                  controller: homeController.editController,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homeController.formKey.currentState!.validate()) {
                          bool success = homeController
                              .addTodo(homeController.editController.text);
                          if (success) {
                            EasyLoading.showSuccess('Todo added');
                          } else {
                            EasyLoading.showError('Todo item already exists');
                          }
                          homeController.editController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.done,
                      ),
                    ),
                  ),
                  validator: (_value) {
                    if (_value == null || _value.trim().isEmpty) {
                      return 'Please enter your todo item';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
