import 'package:docket/data/model/task.dart';
import 'package:docket/modules/home/widgets/add_card_widget.dart';
import 'package:docket/modules/home/widgets/task_card_widget.dart';
import 'package:flutter/material.dart';
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
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.tasks
                    .map((_task) => TaskCardWidget(task: _task))
                    .toList(),
                AddCardWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
