import 'dart:convert';

//section- table name
class Section {
  int? id;
  int? bookId;
  String? bookName;
  int? chapterId;
  int? sectionId;
  String? title;
  String? preface;
  String? number;

  Section({
    this.id,
    this.bookId,
    this.bookName,
    this.chapterId,
    this.sectionId,
    this.title,
    this.preface,
    this.number,
  });

  factory Section.fromJson(String str) => Section.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Section.fromMap(Map<String, dynamic> json) => Section(
        id: json["id"],
        bookId: json["book_id"],
        bookName: json["book_name"],
        chapterId: json["chapter_id"],
        sectionId: json["section_id"],
        title: json["title"],
        preface: json["preface"],
        number: json["number"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "book_id": bookId,
        "book_name": bookName,
        "chapter_id": chapterId,
        "section_id": sectionId,
        "title": title,
        "preface": preface,
        "number": number,
      };
}
