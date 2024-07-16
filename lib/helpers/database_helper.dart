import 'package:alhadid/models/books.dart';
import 'package:alhadid/models/chapter.dart';
import 'package:alhadid/models/hadith.dart';
import 'package:alhadid/models/section.dart';
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
  Future<List<Hadith>> getAllTheHadiths() async {
    if (_db == null) {
      throw "Database is not initialized, initialize using [init()] function";
    }
    List<Map<String, dynamic>> hadiths = [];

    await _db!.transaction((txn) async {
      hadiths = await txn.query(
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

    return hadiths.map((e) => Hadith.fromMap(e)).toList();
  }

  Future<List<Book>> getAllTheBooks() async {
    if (_db == null) {
      throw "Database is not initialized, initialize using [init()] function";
    }
    List<Map<String, dynamic>> hadiths = [];

    await _db!.transaction((txn) async {
      hadiths = await txn.query(
        "books",
        columns: [
          "id",
          "title",
          "title_ar",
          "number_of_hadis",
          "abvr_code",
          "book_name",
          "book_descr"
        ],
      );
    });

    return hadiths.map((e) => Book.fromMap(e)).toList();
  }

  Future<List<Chapter>> getAllTheChapters() async {
    if (_db == null) {
      throw "Database is not initialized, initialize using [init()] function";
    }
    List<Map<String, dynamic>> hadiths = [];

    await _db!.transaction((txn) async {
      hadiths = await txn.query(
        "chapter",
        columns: [
          "id",
          "chapter_id",
          "book_id",
          "title",
          "number",
          "hadis_range",
          "book_name",
        ],
      );
    });

    return hadiths.map((e) => Chapter.fromMap(e)).toList();
  }

  Future<List<Section>> getAllTheSections() async {
    if (_db == null) {
      throw "Database is not initialized, initialize using [init()] function";
    }
    List<Map<String, dynamic>> hadiths = [];

    await _db!.transaction((txn) async {
      hadiths = await txn.query(
        "chapter",
        columns: [
          "id",
          "book_id",
          "book_name",
          "chapter_id",
          "section_id",
          "title",
          "preface",
          "number",
        ],
      );
    });

    return hadiths.map((e) => Section.fromMap(e)).toList();
  }
}
