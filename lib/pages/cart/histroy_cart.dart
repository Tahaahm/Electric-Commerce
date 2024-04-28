// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, use_super_parameters

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elctric_ecommerce/models/product_model.dart';
import 'package:elctric_ecommerce/pages/cart/controller/repo.dart';
import 'package:elctric_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistoryPage extends StatefulWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  State<CartHistoryPage> createState() => _CartHistoryPageState();
}

class _CartHistoryPageState extends State<CartHistoryPage> {
  bool isCartHistoryCleared = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart History'),
      ),
      body: FutureBuilder<List<List<ProductModel>>>(
        future: CartRepo().fetchCartHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final cartHistoryGroups = snapshot.data!;
            cartHistoryGroups.reversed; // Reverse the list
            if (cartHistoryGroups.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "History is empty please to create Invoice it will Authomaticlly added by it self!!",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  )
                ],
              )); // Show empty image
            }
            return _buildCartHistory(cartHistoryGroups);
          }
        },
      ),
    );
  }

  Widget _buildCartHistory(List<List<ProductModel>> cartHistoryGroups) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.builder(
        itemCount: cartHistoryGroups.length,
        itemBuilder: (context, index) {
          final cartItems = cartHistoryGroups[index];

          final orderTime =
              cartItems.isNotEmpty ? cartItems.first.time ?? '' : '';

          final formattedOrderTime = orderTime.isNotEmpty
              ? DateFormat("dd/MM/yyyy hh:mm a")
                  .format(DateTime.parse(orderTime))
              : 'Unknown';

          // Check if all cart items in this group have the same time
          final sameTime =
              cartItems.every((cartItem) => cartItem.time == orderTime);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$formattedOrderTime',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
              sameTime
                  ? _buildCartItemsRow(cartItems, formattedOrderTime)
                  : Column(
                      children: cartItems
                          .map((cartItem) => _buildCartItem(cartItem))
                          .toList(),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItemsRow(
      List<ProductModel> cartItems, String formattedOrderTime) {
    final itemCount = cartItems.length;
    final itemsToShow = itemCount > 3 ? cartItems.sublist(0, 3) : cartItems;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: itemsToShow
                        .map((cartItem) => _buildCartItem(cartItem))
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total",
                      style: Theme.of(Get.context!).textTheme.titleSmall,
                    ),
                    SizedBox(height: 2),
                    Text("${cartItems.length} Items",
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    SizedBox(height: 2),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: TColors.primaryColor,
                            border: Border.all(color: TColors.primaryColor)),
                        alignment: Alignment.center,
                        child: Text(
                          itemCount.toString() + " More",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(ProductModel cartItem) {
    return Container(
      width: 150,
      height: 150, // Adjust as needed
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: TColors.primaryColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: cartItem.imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              color: TColors.primaryColor,
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Text(
              'Image not available',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
