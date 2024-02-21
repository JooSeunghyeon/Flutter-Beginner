import 'dart:convert';

List<ExModel> exModelFromJson(String str) => List<ExModel>.from(json.decode(str).map((x) => ExModel.fromJson(x)));

String exModelToJson(List<ExModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExModel {
  String dayRange;
  String price;
  String range;
  String stockName;

  ExModel({
    required this.dayRange,
    required this.price,
    required this.range,
    required this.stockName,
  });

  factory ExModel.fromJson(Map<String, dynamic> json) => ExModel(
    dayRange: json["day_range"],
    price: json["price"],
    range: json["range"],
    stockName: json["stock_name"],
  );

  Map<String, dynamic> toJson() => {
    "day_range": dayRange,
    "price": price,
    "range": range,
    "stock_name": stockName,
  };
}
