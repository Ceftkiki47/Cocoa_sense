import 'package:get/get.dart';
import 'package:camera/camera.dart' as cam;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class CameraController extends GetxController {
  cam.CameraController? cameraController;
  final ImagePicker _picker = ImagePicker();
  final isFlashOn = false.obs;
  final isCameraInitialized = false.obs;
  final capturedImage = Rx<File?>(null);
  
  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<void> initCamera() async {
    print('🎥 [Camera] Mulai inisialisasi kamera...');
    try {
      // Request camera permission
      print('🎥 [Camera] Meminta permission kamera...');
      final status = await Permission.camera.request();
      print('🎥 [Camera] Status permission: $status');
      
      if (!status.isGranted) {
        print('❌ [Camera] Permission kamera ditolak');
        isCameraInitialized.value = false;
        Get.snackbar('Error', 'Izin kamera diperlukan untuk menggunakan fitur ini');
        return;
      }
      
      print('🎥 [Camera] Mengambil daftar kamera...');
      final cameras = await cam.availableCameras();
      print('🎥 [Camera] Jumlah kamera ditemukan: ${cameras.length}');
      
      if (cameras.isEmpty) {
        print('❌ [Camera] Tidak ada kamera tersedia');
        isCameraInitialized.value = false;
        return;
      }
      
      print('🎥 [Camera] Membuat CameraController...');
      cameraController = cam.CameraController(
        cameras.first,
        cam.ResolutionPreset.high,
        enableAudio: false,
      );
      
      print('🎥 [Camera] Menginisialisasi kamera...');
      await cameraController!.initialize();
      print('✅ [Camera] Kamera berhasil diinisialisasi');
      isCameraInitialized.value = true;
      print('✅ [Camera] isCameraInitialized = true');
    } catch (e) {
      print('❌ [Camera] Error inisialisasi: $e');
      isCameraInitialized.value = false;
      Get.snackbar('Error', 'Gagal inisialisasi kamera: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      
      if (image != null) {
        capturedImage.value = File(image.path);
        Get.toNamed('/photo-result', arguments: image.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memilih gambar: $e');
    }
  }

  Future<void> capturePhoto() async {
    if (cameraController == null || !cameraController!.value.isInitialized) return;
    
    try {
      final image = await cameraController!.takePicture();
      capturedImage.value = File(image.path);
      Get.toNamed('/photo-result', arguments: image.path);
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil foto: $e');
    }
  }

  Future<void> toggleFlash() async {
    if (cameraController == null) return;
    
    try {
      isFlashOn.value = !isFlashOn.value;
      await cameraController!.setFlashMode(
        isFlashOn.value ? cam.FlashMode.torch : cam.FlashMode.off,
      );
    } catch (e) {
      Get.snackbar('Error', 'Gagal toggle flash: $e');
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
