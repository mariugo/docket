import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/utils/extensions.dart';
import '/modules/home/home_controller.dart';
import '/widgets/icons_data.dart';

class AddCardWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  AddCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.deviceWidth;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.deviceWidth),
      child: InkWell(
        onTap: () {},
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.deviceWidth,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
