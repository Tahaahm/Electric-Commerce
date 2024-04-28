// ignore_for_file: prefer_const_constructors

import 'package:elctric_ecommerce/common/constant/binding.dart';
import 'package:elctric_ecommerce/firebase_options.dart';
import 'package:elctric_ecommerce/main_page/main_page.dart';
import 'package:elctric_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: TColors.primaryColor),
        useMaterial3: true,
      ),
      initialBinding: GeneralBindings(),
      home: MainPage(),
    );
  }
}
