import 'dart:convert';

import 'package:elctric_ecommerce/models/product_model.dart';

class UserModel {
  final String username;
  final String email;
  final String phone;
  final String creditCard;
  final List<ProductModel> products;
  final DateTime registrationDate;

  UserModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.creditCard,
    required this.products,
    required this.registrationDate,
  });

  // Convert UserModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'creditCard': creditCard,
      'products': products.map((product) => product.toMap()).toList(),
      'registrationDate': registrationDate.toIso8601String(),
    };
  }

  // Convert UserModel object to a JSON string
  String toJson() {
    return jsonEncode(toMap());
  }
}
