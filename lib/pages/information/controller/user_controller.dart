// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:elctric_ecommerce/models/product_model.dart';
import 'package:elctric_ecommerce/models/user_model.dart';
import 'package:elctric_ecommerce/pages/cart/controller/cart_controller.dart';
import 'package:elctric_ecommerce/pages/information/process_page.dart';
import 'package:elctric_ecommerce/repostory/upload_repsotory.dart';
import 'package:elctric_ecommerce/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  @override
  void dispose() {
    usernameController.dispose();
    locationController.dispose();
    phoneController.dispose();
    creditController.dispose();
    super.dispose();
  }

  void onDisappear() {
    clearTextFields();
  }

  void clearTextFields() {
    usernameController.clear();
    locationController.clear();
    phoneController.clear();
    creditController.clear();
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController creditController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  final _uploadRepository = Get.put(UploadRepository());

  final cartController = CartController.instance;

  Future<void> sendToDatabase(List<ProductModel> products) async {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 300,
            width: 300,
            child: Column(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/animations/processing.json"),
                      SizedBox(
                        height: 12,
                      ),
                      Text("Processing..."),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!keyForm.currentState!.validate()) {
      Get.back();
      return;
    }

    // Create a UserModel object with the user's data
    UserModel user = UserModel(
      username: usernameController.text,
      email: locationController.text,
      phone: phoneController.text,
      creditCard: creditController.text,
      products: products,
      registrationDate: DateTime.now(),
    );

    // Call the repository method to add user and product data to Firestore
    await _uploadRepository.addUserToFirestore(products, user);
    Get.back();
    Get.snackbar("Sucessfully", "The user submited and pay the payment",
        backgroundColor: TColors.primaryColor,
        colorText: Colors.white,
        icon: Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3));
    usernameController.clear();
    locationController.clear();
    phoneController.clear();
    creditController.clear();
    cartController.clearCart();
    Get.offAll(() => ProcessPage());
    keyForm.currentState!.reset();
  }
}
