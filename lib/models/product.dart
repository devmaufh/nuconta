class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.image,
  });

  String id;
  String name;
  String description;
  String image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
      };
}
