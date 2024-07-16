import 'package:alhadid/helpers/database_helper.dart';
import 'package:alhadid/models/books.dart';
import 'package:alhadid/models/chapter.dart';
import 'package:alhadid/models/hadith.dart';
import 'package:alhadid/models/section.dart';
import 'package:get/get.dart';

class HadithDetailsController extends GetxController {
  RxBool loading = false.obs;
  RxBool success = false.obs;
  RxBool error = false.obs;
  final DictionaryDataBaseHelper _dbHelper = DictionaryDataBaseHelper();
  RxList<Hadith> hadithList = <Hadith>[].obs;
  RxList<Book> bookList = <Book>[].obs;
  RxList<Section> sectionList = <Section>[].obs;
  RxList<Chapter> chapterList = <Chapter>[].obs;
  Future<void> initializeDatabase() async {
    await _dbHelper.init();
    loading.value = true;
    _loadData();
  }

  Future<void> _loadData() async {
    hadithList.value = await _dbHelper.getAllTheHadiths();
    bookList.value = await _dbHelper.getAllTheBooks();
    chapterList.value = await _dbHelper.getAllTheChapters();
    sectionList.value = await _dbHelper.getAllTheSections();
    if (hadithList.isEmpty &&
        bookList.isEmpty &&
        chapterList.isEmpty &&
        sectionList.isEmpty) {
      error.value = true;
      loading.value = false;
    } else if (hadithList.isNotEmpty &&
        bookList.isNotEmpty &&
        chapterList.isNotEmpty &&
        sectionList.isNotEmpty) {
      success.value = true;
      loading.value = false;
    }
  }
}
