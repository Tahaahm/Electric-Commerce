// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elctric_ecommerce/models/product_model.dart';
import 'package:get/get.dart';

class FetchRepository extends GetxController {
  static FetchRepository get instance => Get.find();

  // Fetch products where isFullHome is false
  Future<List<ProductModel>> fetchProductsIsNotFullHome() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('isFullHome', isEqualTo: false)
          .get();

      final List<ProductModel> products = querySnapshot.docs
          .map(
              (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      print("object22");
      return products;
    } catch (e) {
      print('Error fetching products where isFullHome is false: $e');
      return [];
    }
  }

  // Fetch products where isFullHome is true
  Future<List<ProductModel>> fetchProductsIsFullHome() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('isFullHome', isEqualTo: true)
          .get();

      final List<ProductModel> products = querySnapshot.docs
          .map(
              (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return products;
    } catch (e) {
      print('Error fetching products where isFullHome is true: $e');
      return [];
    }
  }
}
