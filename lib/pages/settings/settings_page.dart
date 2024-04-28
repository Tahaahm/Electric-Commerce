// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:elctric_ecommerce/repostory/upload_repsotory.dart';
import 'package:elctric_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final controller = Get.put(UploadRepository());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Settings",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            ListTile(
              leading: Icon(Iconsax.user, color: TColors.primaryColor),
              title: Text("Username"),
              subtitle: Text("Test"),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.mail_outline, color: TColors.primaryColor),
              title: Text("Email"),
              subtitle: Text("test@gmail.com"),
            ),
            SizedBox(height: 10),
            ListTile(
              leading:
                  Icon(Iconsax.cloud_lightning, color: TColors.primaryColor),
              title: Text("Mode"),
              subtitle: Text("Light"),
            ),
            SizedBox(height: 32),
            ListTile(
              onTap: () {
                Get.snackbar("Sorry!!",
                    "This data wont upload becuase we already uploaded",
                    backgroundColor: TColors.primaryColor,
                    colorText: Colors.white,
                    icon: Icon(
                      Iconsax.warning_2,
                      color: Colors.white,
                    ));
                //here before we added some product from there but now we dont need
                //controller.addProductsToFirestore(generateDummyProductData()),
              },
              leading:
                  Icon(Iconsax.document_upload, color: TColors.primaryColor),
              title: Text("Upload Data"),
              subtitle: Text("Data"),
            ),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                Get.snackbar("Sorry!!",
                    "This Action cant work right now, please try again later...",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    icon: Icon(
                      Iconsax.warning_2,
                      color: Colors.white,
                    ));
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.primaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  "LogOut",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
