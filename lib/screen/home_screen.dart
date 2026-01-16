import 'package:cocoa_sense/screen/widget/card/feature_card.dart';
import 'package:cocoa_sense/screen/widget/card/info_card.dart';
import 'package:cocoa_sense/screen/widget/card/sensor_realtime_card.dart';
import 'package:cocoa_sense/screen/widget/garden_status.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D7A4F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.eco,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'COCOA-SENSE',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'BERANDA',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {},
                      color: Colors.black87,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Garden Status Card
                const GardenStatusCard(
                  gardenName: 'Kebun Jonggol Blok C',
                  pohon: 1240,
                  buah: '~8.5k',
                  kesehatan: '98%',
                ),
                const SizedBox(height: 24),

                // Info Cards Row
                const Row(
                  children: [
                    Expanded(
                      child: InfoCard(
                        label: 'CAPAIAN PANEN',
                        value: '420',
                        unit: 'Kg/Bln',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: InfoCard(
                        label: 'HOK TERPAKAI',
                        value: '12',
                        unit: 'Hari',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Deteksi AI Card
                const FeatureCard(
                  icon: Icons.camera_alt,
                  title: 'Deteksi AI',
                  subtitle: 'Scan buah kakao\nsekarang',
                ),
                const SizedBox(height: 20),

                // Sensor Section Header
                Row(
                  children: [
                    const Icon(
                      Icons.show_chart,
                      size: 20,
                      color: Color(0xFF2D7A4F),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'SENSOR KEBUN REAL-TIME',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Sensor Temperature Card
                SensorRealtimeCard(
                  sensorType: 'Suhu Udara',
                  currentValue: 28.4,
                  unit: '°C',
                  icon: Icons.thermostat,
                  chartData: const [27.5, 27.8, 28.0, 28.2, 28.5, 28.3, 28.4, 28.6, 28.4],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}