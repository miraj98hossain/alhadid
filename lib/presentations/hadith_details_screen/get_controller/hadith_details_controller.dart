import 'package:alhadid/helpers/database_helper.dart';
import 'package:alhadid/models/hadith.dart';
import 'package:get/get.dart';

class HadithDetailsController extends GetxController {
  RxBool loading = false.obs;
  RxBool success = false.obs;
  RxBool error = false.obs;
  final DictionaryDataBaseHelper _dbHelper = DictionaryDataBaseHelper();
  RxList<Hadith> hadithList = <Hadith>[].obs;

  Future<void> initializeDatabase() async {
    await _dbHelper.init();
    loading.value = true;
    _loadHadithData();
  }

  Future<void> _loadHadithData() async {
    hadithList.value = await _dbHelper.getAllTheHadiths();
    if (hadithList.isEmpty) {
      error.value = true;
      loading.value = false;
    } else if (hadithList.isNotEmpty) {
      success.value = true;
      loading.value = false;
    }
  }
}
