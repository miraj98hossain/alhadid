import 'dart:convert';

class Hadith {
  int? hadithId;
  int? bookId;
  String? bookName;
  int? chapterId;
  int? sectionId;
  String? narrator;
  String? bn;
  String? ar;
  String? arDiacless;
  String? note;
  int? gradeId;
  String? grade;
  String? gradeColor;

  Hadith({
    this.hadithId,
    this.bookId,
    this.bookName,
    this.chapterId,
    this.sectionId,
    this.narrator,
    this.bn,
    this.ar,
    this.arDiacless,
    this.note,
    this.gradeId,
    this.grade,
    this.gradeColor,
  });

  factory Hadith.fromJson(String str) => Hadith.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Hadith.fromMap(Map<String, dynamic> json) => Hadith(
        hadithId: json["hadith_id"],
        bookId: json["book_id"],
        bookName: json["book_name"],
        chapterId: json["chapter_id"],
        sectionId: json["section_id"],
        narrator: json["narrator"],
        bn: json["bn"],
        ar: json["ar"],
        arDiacless: json["ar_diacless"],
        note: json["note"],
        gradeId: json["grade_id"],
        grade: json["grade"],
        gradeColor: json["grade_color"],
      );

  Map<String, dynamic> toMap() => {
        "hadith_id": hadithId,
        "book_id": bookId,
        "book_name": bookName,
        "chapter_id": chapterId,
        "section_id": sectionId,
        "narrator": narrator,
        "bn": bn,
        "ar": ar,
        "ar_diacless": arDiacless,
        "note": note,
        "grade_id": gradeId,
        "grade": grade,
        "grade_color": gradeColor,
      };
}
