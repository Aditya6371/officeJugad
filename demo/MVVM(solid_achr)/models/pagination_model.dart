import 'dart:convert';

class PaginationModel {
  int? page;
  int? limit;
  int? pages;

  PaginationModel({
    this.page,
    this.limit,
    this.pages,
  });

  factory PaginationModel.fromRawJson(String str) =>
      PaginationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        page: json["page"],
        limit: json["limit"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "pages": pages,
      };
}
