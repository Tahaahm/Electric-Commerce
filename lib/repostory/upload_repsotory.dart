// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elctric_ecommerce/models/product_model.dart';
import 'package:elctric_ecommerce/models/user_model.dart';
import 'package:get/get.dart';

class UploadRepository extends GetxController {
  static UploadRepository get instance => Get.find();

  Future<void> addProductsToFirestore(List<ProductModel> products) async {
    try {
      // Initialize Firebase Firestore
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Iterate over each product and add it to Firestore
      for (final product in products) {
        await firestore
            .collection('products')
            .doc(product.title)
            .set(product.toMap());
      }
      print('Products added to Firestore successfully');
    } catch (e) {
      print('Error adding products to Firestore: $e');
    }
  }

  Future<void> addUserToFirestore(
      List<ProductModel> products, UserModel user) async {
    try {
      // Initialize Firebase Firestore
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Convert UserModel to a map
      final Map<String, dynamic> userData = user.toMap();

      // Add user data to Firestore
      await firestore.collection('users').doc(user.username).set(userData);

      // Iterate over each product and add it to Firestore
      for (final product in products) {
        await firestore
            .collection('products')
            .doc(product.title)
            .set(product.toMap());
      }

      print('Products and user data added to Firestore successfully');
    } catch (e) {
      print('Error adding products and user data to Firestore: $e');
    }
  }
}
