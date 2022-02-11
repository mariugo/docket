import 'package:docket/core/values/keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DataStoreService extends GetxService {
  late GetStorage _dataStore;

  Future<DataStoreService> init() async {
    _dataStore = GetStorage();
    await _dataStore.writeIfNull(taskKey, []);
    return this;
  }
}
