import 'dart:convert';

//chapter-table name
class Chapter {
  int? id;
  int? chapterId;
  int? bookId;
  String? title;
  int? number;
  String? hadisRange;
  String? bookName;

  Chapter({
    this.id,
    this.chapterId,
    this.bookId,
    this.title,
    this.number,
    this.hadisRange,
    this.bookName,
  });

  factory Chapter.fromJson(String str) => Chapter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Chapter.fromMap(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        chapterId: json["chapter_id"],
        bookId: json["book_id"],
        title: json["title"],
        number: json["number"],
        hadisRange: json["hadis_range"],
        bookName: json["book_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "chapter_id": chapterId,
        "book_id": bookId,
        "title": title,
        "number": number,
        "hadis_range": hadisRange,
        "book_name": bookName,
      };
}
