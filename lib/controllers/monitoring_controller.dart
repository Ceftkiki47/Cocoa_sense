import 'package:get/get.dart';
import 'dart:async';
import 'dart:math' as math;

class MonitoringController extends GetxController {
  final phValue = 6.4.obs;
  final sensorCount = 850.obs;
  final isSystemActive = true.obs;
  
  Timer? _updateTimer;

  @override
  void onInit() {
    super.onInit();
    startDataUpdates();
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }

  void startDataUpdates() {
    _updateTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      phValue.value = 6.4 + (math.Random().nextDouble() - 0.5) * 0.3;
      sensorCount.value = 845 + math.Random().nextInt(15);
    });
  }

  void refreshData() {
    phValue.value = 6.4 + (math.Random().nextDouble() - 0.5) * 0.3;
    sensorCount.value = 845 + math.Random().nextInt(15);
    Get.snackbar(
      'Berhasil',
      'Data berhasil diperbarui',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void exportData() {
    // TODO: Implement export functionality
    Get.snackbar(
      'Export',
      'Fitur export akan segera tersedia',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void viewDetailedAnalytics() {
    // TODO: Navigate to analytics screen
    Get.snackbar(
      'Analytics',
      'Fitur analytics akan segera tersedia',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
