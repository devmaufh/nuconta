// To parse this JSON data, do
//
//     final offer = offerFromJson(jsonString);

import 'dart:convert';

import 'package:nuconta_marketplace/models/product.dart';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

String offerToJson(Offer data) => json.encode(data.toJson());

class Offer {
  Offer({
    this.id,
    this.price,
    this.product,
  });

  String id;
  int price;
  Product product;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        price: json["price"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "product": product.toJson(),
      };
}
