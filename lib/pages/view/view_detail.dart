// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elctric_ecommerce/common/widget/expanded/expanded_text.dart';
import 'package:elctric_ecommerce/models/product_model.dart';
import 'package:elctric_ecommerce/pages/cart/cart_page.dart';
import 'package:elctric_ecommerce/pages/cart/controller/cart_controller.dart';
import 'package:elctric_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ViewDetail extends StatelessWidget {
  const ViewDetail({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    image: DecorationImage(
                        image:
                            CachedNetworkImageProvider(productModel.imageUrl),
                        fit: BoxFit.cover)),
              ),
            ),
            GetBuilder<CartController>(
              builder: (controller) => Positioned(
                top: 45,
                left: 15,
                right: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CartPage());
                      },
                      child: Stack(
                        children: [
                          Icon(Iconsax.shopping_cart4),
                          controller.cartItems.length > 0
                              ? Positioned(
                                  right: 0,
                                  top: 2,
                                  child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                        color: TColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        "${controller.cartItems.length}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 7),
                                      ),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 360,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productModel.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "\$${productModel.price}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: TColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ExpandedTextWidget(
                          text:
                              "${productModel.description} For the testing the app we need lot of desciption to show what we were design the scroll of the desciption is real nice and pretyy good to see itFor the testing the app we need lot of desciption to show what we were design the scroll of the desciption is real nice and pretyy good to see itFor the testing the app we need lot of desciption to show what we were design the scroll of the desciption is real nice and pretyy good to see itFor the testing the app we need lot of desciption to show what we were design the scroll of the desciption is real nice and pretyy good to see it"),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
            builder: (controller) => Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(
                      40,
                    ),
                  ),
                ),
                padding:
                    EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
                child: GestureDetector(
                  onTap: () => controller.addItem(productModel),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: TColors.primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "\$${productModel.price} | add to Cart",
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
