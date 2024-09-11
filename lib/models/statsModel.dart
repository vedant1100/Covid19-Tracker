// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  final List<Map<String, double>>? countryInformation;

  ProductsModel({
    this.countryInformation,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    countryInformation: json["CountryInformation"] == null ? [] : List<Map<String, double>>.from(json["CountryInformation"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, double>(k, v?.toDouble())))),
  );

  Map<String, dynamic> toJson() => {
    "CountryInformation": countryInformation == null ? [] : List<dynamic>.from(countryInformation!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}
