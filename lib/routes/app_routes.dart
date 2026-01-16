import 'package:get/get.dart';
import 'package:cocoa_sense/screen/splash_screen.dart';
import 'package:cocoa_sense/screen/welcome_screen.dart';
import 'package:cocoa_sense/screen/main_screen.dart';
import 'package:cocoa_sense/screen/home_screen.dart';
import 'package:cocoa_sense/screen/map_screen.dart';
import 'package:cocoa_sense/screen/camera_scan_screen.dart';
import 'package:cocoa_sense/screen/monitoring_screen.dart';
import 'package:cocoa_sense/screen/photo_result_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const main = '/main';
  static const home = '/home';
  static const map = '/map';
  static const camera = '/camera';
  static const monitoring = '/monitoring';
  static const photoResult = '/photo-result';
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.map,
      page: () => const MapScreen(),
    ),
    GetPage(
      name: AppRoutes.camera,
      page: () => const CameraScanScreen(),
    ),
    GetPage(
      name: AppRoutes.monitoring,
      page: () => const MonitoringScreen(),
    ),
    GetPage(
      name: AppRoutes.photoResult,
      page: () => const PhotoResultScreen(),
    ),
  ];
}
