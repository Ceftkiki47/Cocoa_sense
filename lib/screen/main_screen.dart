import 'package:cocoa_sense/screen/map_screen.dart';
import 'package:cocoa_sense/screen/monitoring_screen.dart';
import 'package:cocoa_sense/screen/profile_screen.dart';
import 'package:cocoa_sense/screen/widget/history_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cocoa_sense/controllers/main_controller.dart';
import 'home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    
    final List<Widget> screens = [
      const HomeScreen(),
      const MapScreen(),
      const Center(child: Text('Kamera')),
      const MonitoringScreen(),
      const ProfileScreen()
    ];

    return Obx(() => Scaffold(
      body: Stack(
        children: [
          screens[controller.selectedIndex.value],
          // History FAB positioned absolutely
          Positioned(
            bottom: 100,
            right: 20,
            child: const HistoryFloatingButton(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,
            color: Colors.white,
            elevation: 0,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.grid_view, 'BERANDA', 0, controller),
                  _buildNavItem(Icons.map_outlined, 'PETA', 1, controller),
                  const SizedBox(width: 40),
                  _buildNavItem(Icons.sensors, 'IOT HUB', 3, controller),
                  _buildNavItem(Icons.person_outline, 'PROFIL', 4, controller),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'camera_fab',
        onPressed: () => controller.onItemTapped(2),
        backgroundColor: const Color(0xFF2D7A4F),
        elevation: 4,
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }

  Widget _buildNavItem(IconData icon, String label, int index, MainController controller) {
    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;
      return InkWell(
        onTap: () => controller.onItemTapped(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFF2D7A4F) : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? const Color(0xFF2D7A4F) : Colors.grey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}