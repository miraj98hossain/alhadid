import 'dart:convert';

//books-table name
class Book {
  int? id;
  String? title;
  String? titleAr;
  int? numberOfHadis;
  String? abvrCode;
  String? bookName;
  String? bookDescr;

  Book({
    this.id,
    this.title,
    this.titleAr,
    this.numberOfHadis,
    this.abvrCode,
    this.bookName,
    this.bookDescr,
  });

  factory Book.fromJson(String str) => Book.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Book.fromMap(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        titleAr: json["title_ar"],
        numberOfHadis: json["number_of_hadis"],
        abvrCode: json["abvr_code"],
        bookName: json["book_name"],
        bookDescr: json["book_descr"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "title_ar": titleAr,
        "number_of_hadis": numberOfHadis,
        "abvr_code": abvrCode,
        "book_name": bookName,
        "book_descr": bookDescr,
      };
}
