// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:elctric_ecommerce/main_page/main_page.dart';
import 'package:elctric_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProcessPage extends StatelessWidget {
  const ProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animations/successfully_payment_2.json",
                repeat: false, height: 250),
            GestureDetector(
              onTap: () {
                Get.offAll(() => MainPage());
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: TColors.primaryColor,
                ),
                alignment: Alignment.center,
                child: Text("Done"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
