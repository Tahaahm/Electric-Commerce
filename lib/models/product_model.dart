import 'dart:convert';

class ProductModel {
  final String title;
  final String description;
  final int stock;
  final double price;
  final String imageUrl;
  final bool isFullHome; // New field
  int? quantity; // Optional field for quantity
  bool? ifExist; // Optional field for existence
  String? time;

  ProductModel(
      {required this.title,
      required this.description,
      required this.stock,
      required this.price,
      required this.imageUrl,
      required this.isFullHome,
      this.quantity, // Make quantity optional
      this.ifExist, // Make ifExist optional
      this.time});

  // Convert ProductModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'stock': stock,
      'price': price,
      'imageUrl': imageUrl,
      'isFullHome': isFullHome,
    };
  }

  // Factory method to create a ProductModel object from a Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      stock: map['stock'] ?? 0,
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      isFullHome: map['isFullHome'] ?? false,
    );
  }

  // Convert ProductModel object to a JSON string
  String toJson() {
    return jsonEncode(toMap());
  }

  // Factory method to create a ProductModel object from JSON string
  factory ProductModel.fromJson(String jsonString) {
    return ProductModel.fromMap(jsonDecode(jsonString));
  }
}
