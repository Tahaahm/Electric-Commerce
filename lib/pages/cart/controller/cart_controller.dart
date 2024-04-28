// ignore_for_file: prefer_const_constructors

import 'package:elctric_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elctric_ecommerce/models/product_model.dart';
import 'package:iconsax/iconsax.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  void addItem(ProductModel product) {
    int existingIndex =
        _cartItems.indexWhere((item) => item.title == product.title);
    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity =
          (_cartItems[existingIndex].quantity ?? 0) + 1;
    } else {
      ProductModel newProduct = ProductModel(
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        quantity: 1,
        description: product.description,
        time: DateTime.now().toString(),
        stock: product.stock,
        isFullHome: product.isFullHome,
      );
      _cartItems.add(newProduct);
      _showSuccessMessage(product.title);
    }
    update(); // Update the UI
  }

  void increaseQuantity(ProductModel product) {
    int existingIndex =
        _cartItems.indexWhere((item) => item.title == product.title);
    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity =
          (_cartItems[existingIndex].quantity ?? 0) + 1;
    }
    update();
  }

  void decreaseQuantity(ProductModel product) {
    int existingIndex =
        _cartItems.indexWhere((item) => item.title == product.title);
    if (existingIndex != -1) {
      if (_cartItems[existingIndex].quantity! > 1) {
        _cartItems[existingIndex].quantity =
            (_cartItems[existingIndex].quantity ?? 0) - 1;
      } else {
        // Remove the item if the quantity becomes zero
        _cartItems.removeAt(existingIndex);
      }

      update(); // Update the UI
    }
  }

  void _showSuccessMessage(String productName) {
    Get.snackbar(productName, "The Product added to the cart",
        backgroundColor: TColors.primaryColor,
        colorText: Colors.white,
        icon: Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
        duration: Duration(seconds: 1));
  }

  String get formattedTotalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += (item.price) * (item.quantity ?? 0);
    }
    return total.toStringAsFixed(2);
  }

  void clearCart() {
    _cartItems.clear();
    update(); // Update the UI
  }
}
