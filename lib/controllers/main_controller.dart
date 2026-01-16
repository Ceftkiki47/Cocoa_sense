import 'package:get/get.dart';
import 'package:cocoa_sense/routes/app_routes.dart';

class MainController extends GetxController {
  final selectedIndex = 0.obs;

  void onItemTapped(int index) {
    if (index == 2) {
      // Navigate to camera screen
      Get.toNamed(AppRoutes.camera);
      return;
    }
    selectedIndex.value = index;
  }
}
