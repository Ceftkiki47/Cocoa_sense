import 'package:get/get.dart';
import 'package:cocoa_sense/routes/app_routes.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;

  final userName = 'Silas IPB 2026'.obs;
  final faculty = 'FAKULTAS PERTANIAN'.obs;
  final program = 'MAHASISWA'.obs;
  final imageUrl = 'https/picsum.photos/200'.obs;

  void onItemTapped(int index) {
    if (index == 2) {
      // Navigate to camera screen
      Get.toNamed(AppRoutes.camera);
      return;
    }
    selectedIndex.value = index;
  }
}
