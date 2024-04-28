// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, prefer_const_constructors_in_immutables

import 'package:elctric_ecommerce/main_page/main_page.dart';
import 'package:elctric_ecommerce/models/product_model.dart';
import 'package:elctric_ecommerce/pages/cart/controller/cart_controller.dart';
import 'package:elctric_ecommerce/pages/information/controller/user_controller.dart';
import 'package:elctric_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class InformationPage extends StatefulWidget {
  InformationPage({super.key, required this.prouctModel});
  final List<ProductModel> prouctModel;

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => MainPage());
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Form(
              key: controller.keyForm,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      customTextField(
                        controller: controller.usernameController,
                        title: "Username",
                        iconData: Iconsax.user,
                      ),
                      SizedBox(height: 15),
                      customTextField(
                        controller: controller.phoneController,
                        title: "Phone",
                        iconData: Iconsax.call,
                        type: TextInputType.phone,
                      ),
                      SizedBox(height: 15),
                      customTextField(
                        controller: controller.creditController,
                        title: "Credit Card",
                        iconData: Iconsax.card,
                        type: TextInputType.number,
                      ),
                      SizedBox(height: 15),
                      customTextField(
                        controller: controller.locationController,
                        title: "Location",
                        iconData: Iconsax.location,
                        type: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 240,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Purches Summary",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GetBuilder<CartController>(
                builder: (controller) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "\$${controller.formattedTotalPrice}",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          "\$0.00",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => controller.sendToDatabase(widget.prouctModel),
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: TColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Submit the Payment",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class customTextField extends StatelessWidget {
  const customTextField({
    super.key,
    required this.title,
    this.controller,
    required this.iconData,
    this.type,
  });
  final String title;
  final TextEditingController? controller;
  final IconData iconData;
  final TextInputType? type;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Filed up the $title";
        } else {
          return null;
        }
      },
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        label: Text(title),
        prefixIcon: Icon(
          iconData,
          color: Colors.black,
        ),
        errorMaxLines: 3,
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        labelStyle: TextStyle().copyWith(fontSize: 14, color: Colors.black),
        hintStyle: TextStyle().copyWith(fontSize: 14, color: Colors.black),
        errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
        floatingLabelStyle:
            TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
        border: OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
        errorBorder: OutlineInputBorder().copyWith(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(width: 2, color: Colors.orange),
        ),
      ),
    );
  }
}
