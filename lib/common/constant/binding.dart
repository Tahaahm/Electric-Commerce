import 'package:elctric_ecommerce/pages/cart/controller/cart_controller.dart';
import 'package:elctric_ecommerce/pages/information/controller/user_controller.dart';
import 'package:elctric_ecommerce/repostory/fetch_repostory.dart';
import 'package:elctric_ecommerce/repostory/upload_repsotory.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(CartController());
    Get.put(UserController());
    Get.put(UploadRepository());
    Get.put(FetchRepository());
  }
}
