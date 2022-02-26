import 'package:docket/core/values/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../data/model/task.dart';
import '/core/utils/extensions.dart';
import '/modules/home/home_controller.dart';
import '/widgets/icons_data.dart';

class AddCardWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  AddCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.widthPoints;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.widthPoints),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(
              vertical: 5.0.widthPoints,
            ),
            radius: 5.0,
            title: 'Task Type',
            content: Form(
              key: homeController.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.0.widthPoints,
                    ),
                    child: TextFormField(
                      controller: homeController.editController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0.widthPoints,
                    ),
                    child: Wrap(
                      spacing: 2.0.widthPoints,
                      children: icons
                          .map(
                            (_icon) => Obx(() {
                              final index = icons.indexOf(_icon);
                              return ChoiceChip(
                                selectedColor: Colors.grey[200],
                                pressElevation: 0,
                                backgroundColor: Colors.white,
                                label: _icon,
                                selected:
                                    homeController.chipIndex.value == index,
                                onSelected: (bool selected) {
                                  homeController.chipIndex.value =
                                      selected ? index : 0;
                                },
                              );
                            }),
                          )
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      if (homeController.formKey.currentState!.validate()) {
                        int icon = icons[homeController.chipIndex.value]
                            .icon!
                            .codePoint;
                        String color = icons[homeController.chipIndex.value]
                            .color!
                            .toHex();
                        var task = Task(
                          title: homeController.editController.text,
                          icon: icon,
                          color: color,
                        );
                        Get.back();
                        homeController.addTask(task)
                            ? EasyLoading.showSuccess('Task created')
                            : EasyLoading.showError('Duplicated task');
                      }
                    },
                    child: const Text(
                      'Confirm',
                    ),
                  ),
                ],
              ),
            ),
          );
          homeController.editController.clear();
          homeController.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.widthPoints,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
