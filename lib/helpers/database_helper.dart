import 'package:alhadid/models/hadith.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class DictionaryDataBaseHelper {
  Database? _db;

  Future<void> init() async {
    io.Directory applicationDirectory =
        await getApplicationDocumentsDirectory();

    String dbPathHadith = path.join(applicationDirectory.path, "hadith_db.db");

    bool dbExistshadith = await io.File(dbPathHadith).exists();

    if (!dbExistshadith) {
      // Copy from asset
      ByteData data =
          await rootBundle.load(path.join("assets", "hadith_db.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPathHadith).writeAsBytes(bytes, flush: true);
    }

    _db = await openDatabase(dbPathHadith);
  }

  /// get all the words from english dictionary
  Future<List<Hadith>> getAllTheWordsEnglish() async {
    if (_db == null) {
      throw "Database is not initialized, initialize using [init()] function";
    }
    List<Map<String, dynamic>> words = [];

    await _db!.transaction((txn) async {
      words = await txn.query(
        "hadith",
        columns: [
          "hadith_id",
          "book_id",
          "book_name",
          "chapter_id",
          "section_id",
          "narrator",
          "bn",
          "ar",
          "ar_diacless",
          "note",
          "grade_id",
          "grade",
          "grade_color"
        ],
      );
    });

    return words.map((e) => Hadith.fromMap(e)).toList();
  }
}
