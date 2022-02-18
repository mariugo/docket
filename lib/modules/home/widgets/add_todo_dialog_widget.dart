import 'package:docket/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class AddTodoDialogWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  AddTodoDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeController.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.deviceWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeController.editController.clear();
                      homeController.changeTask(null);
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    onPressed: () {
                      if (homeController.formKey.currentState!.validate()) {
                        if (homeController.task.value == null) {
                          EasyLoading.showError('Please select task type');
                        } else {
                          bool success = homeController.updateTask(
                            homeController.task.value!,
                            homeController.editController.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess('Todo item added');
                            Get.back();
                            homeController.changeTask(null);
                          } else {
                            EasyLoading.showError('Todo item already exists');
                          }
                          homeController.editController.clear();
                        }
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.deviceWidth),
              child: Text(
                'New Task',
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.deviceWidth),
              child: TextFormField(
                  controller: homeController.editController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  autofocus: true,
                  validator: (_value) {
                    if (_value == null || _value.trim().isEmpty) {
                      return 'Please, enter your todo item';
                    }
                    return null;
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5.0.deviceWidth,
                left: 5.0.deviceWidth,
                right: 5.0.deviceWidth,
                bottom: 2.0.deviceWidth,
              ),
              child: Text(
                'Add task to:',
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            ...homeController.tasks.map(
              (_element) => Obx(
                () => InkWell(
                  onTap: () => homeController.changeTask(_element),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 3.0.deviceWidth,
                      horizontal: 5.0.deviceWidth,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              IconData(
                                _element.icon,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: HexColor.fromHex(
                                _element.color,
                              ),
                            ),
                            SizedBox(
                              width: 3.0.deviceWidth,
                            ),
                            Text(
                              _element.title,
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (homeController.task.value == _element)
                          const Icon(
                            Icons.check,
                            color: Colors.blue,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
