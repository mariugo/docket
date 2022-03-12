import 'package:docket/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '/modules/home/home_controller.dart';
import '/core/utils/extensions.dart';

class ReportView extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var createdTasks = homeController.getTotalTasks();
          var completedTasks = homeController.getTotalDoneTasks();
          var liveTasks = createdTasks - completedTasks;
          var percentageTasks =
              (completedTasks / createdTasks * 100).toStringAsFixed(0);
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  4.0.widthPoints,
                ),
                child: Text(
                  'My Report',
                  style: TextStyle(
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.0.widthPoints,
                ),
                child: Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3.0.widthPoints,
                  horizontal: 4.0.widthPoints,
                ),
                child: const Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3.0.widthPoints,
                  horizontal: 5.0.widthPoints,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.green, liveTasks, 'Live tasks'),
                    _buildStatus(Colors.orange, completedTasks, 'Completed'),
                    _buildStatus(Colors.blue, createdTasks, 'Created'),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0.widthPoints,
              ),
              UnconstrainedBox(
                child: Center(
                  child: SizedBox(
                    width: 70.0.widthPoints,
                    height: 70.0.widthPoints,
                    child: CircularStepProgressIndicator(
                      totalSteps: createdTasks == 0 ? 1 : createdTasks,
                      currentStep: completedTasks,
                      stepSize: 20,
                      selectedColor: green,
                      unselectedColor: Colors.grey[200],
                      padding: 0,
                      width: 150,
                      height: 150,
                      selectedStepSize: 22,
                      roundedCap: (_, __) => true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${createdTasks == 0 ? 0 : percentageTasks} %',
                            style: TextStyle(
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 1.0.widthPoints,
                          ),
                          Text(
                            'Efficiency',
                            style: TextStyle(
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Row _buildStatus(Color color, int number, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.widthPoints,
          width: 3.0.widthPoints,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 0.5.widthPoints,
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: 3.0.widthPoints,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 2.0.widthPoints,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
