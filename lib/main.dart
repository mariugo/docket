import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/data/local/data_store_service.dart';
import '/modules/home/home_view.dart';
import '/modules/home/home_binding.dart';

main() async {
  await GetStorage.init();
  await Get.putAsync(() => DataStoreService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Docket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
      home: const HomeView(),
    );
  }
}
