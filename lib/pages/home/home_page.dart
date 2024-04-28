// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elctric_ecommerce/common/widget/container/list_of_home_container.dart';
import 'package:elctric_ecommerce/common/widget/shimmer.dart';
import 'package:elctric_ecommerce/models/product_model.dart';
import 'package:elctric_ecommerce/pages/cart/cart_page.dart';
import 'package:elctric_ecommerce/pages/cart/controller/cart_controller.dart';
import 'package:elctric_ecommerce/pages/see_all/see_all_page.dart';
import 'package:elctric_ecommerce/pages/view/view_detail.dart';
import 'package:elctric_ecommerce/repostory/fetch_repostory.dart';
import 'package:elctric_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 45),
          child: LayoutBuilder(
            builder: (context, constraints) => RefreshIndicator(
              onRefresh: () async {
                FetchRepository.instance.fetchProductsIsFullHome();
                FetchRepository.instance.fetchProductsIsNotFullHome();

                Get.forceAppUpdate();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<CartController>(
                      builder: (controller) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Find Awesome Electricity device",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
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
                                                    color: Colors.white,
                                                    fontSize: 7),
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
                    SizedBox(height: 15),
                    Text(
                      "New Arrive",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 5),

                    //The list of the house device electronic
                    ListofHomeContainer(),

                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Featured",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(
                                () => SeeAllPage(),
                                transition: Transition.rightToLeft,
                              );
                            },
                            child: Text(
                              "See All",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: TColors.primaryColor),
                            ))
                      ],
                    ),
                    FutureBuilder<List<ProductModel>>(
                      future:
                          FetchRepository.instance.fetchProductsIsNotFullHome(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.88,
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TShimmerEffect(width: 100, height: 120),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Text('No products found');
                        } else {
                          // Display only the first 2 products in the GridView
                          final List<ProductModel> products = snapshot.data!;
                          final List<ProductModel> displayedProducts =
                              products.take(2).toList();

                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: displayedProducts.length,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.88,
                            ),
                            itemBuilder: (context, index) {
                              final ProductModel product =
                                  displayedProducts[index];
                              return GestureDetector(
                                onTap: () {
                                  // Navigate to view detail page
                                  Get.to(
                                      () => ViewDetail(
                                            productModel: product,
                                          ),
                                      transition: Transition.downToUp);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.06),
                                          blurRadius: 32,
                                          spreadRadius: 1,
                                          offset: Offset(2, 2),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(6),
                                          height: 135,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color:
                                                Colors.grey.withOpacity(0.05),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: product.imageUrl,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()), // Placeholder widget
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          child: Column(
                                            children: [
                                              Text(
                                                product.title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                '\$${product.price}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color:
                                                          TColors.primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
