// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:elctric_ecommerce/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  static const String _cartHistoryKey = 'cartHistory';
  Future<void> addToCartHistory(
    List<ProductModel> cartItems,
    DateTime orderTime,
  ) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> cartHistory = prefs.getStringList(_cartHistoryKey) ?? [];

      print('Products to be added to Cart History: $cartItems');

      // Add each cart item to the cart history along with the given discount, buyer name, and sold status
      for (final item in cartItems) {
        item.time = orderTime.toString(); // Set the time for each cart item

        // Set the discount for the cart item

        // Convert the cart item to a Map
        final Map<String, dynamic> itemMap = item.toMap();

        // Encode the cart item Map to JSON and add it to the cart history
        cartHistory.add(jsonEncode(itemMap));
      }

      // Store the updated cart history in SharedPreferences
      await prefs.setStringList(_cartHistoryKey, cartHistory);
    } catch (e) {
      print('Error adding to cart history: $e');
    }
  }

  Future<List<List<ProductModel>>> fetchCartHistory() async {
    try {
      final List<List<ProductModel>> cartHistoryGroups = [];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? cartHistory = prefs.getStringList(_cartHistoryKey);

      print('Cart History from SharedPreferences: $cartHistory');

      if (cartHistory != null) {
        for (final json in cartHistory) {
          // Decode each JSON string individually
          try {
            final Map<String, dynamic> cartItemMap = jsonDecode(json);
            final ProductModel cartItem = ProductModel.fromMap(cartItemMap);
            cartHistoryGroups
                .add([cartItem]); // Add each cart item to a new group
          } catch (e) {
            print('Error decoding JSON: $e');
            continue; // Skip to the next element if decoding fails
          }
        }
      }

      return cartHistoryGroups;
    } catch (e) {
      print('Error getting cart history: $e');
      return [];
    }
  }
}
