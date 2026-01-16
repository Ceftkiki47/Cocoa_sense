import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cocoa_sense/models/detection_result.dart';
import 'package:cocoa_sense/controllers/detection_history_controller.dart';

class AIResultScreen extends StatelessWidget {
  const AIResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final String imagePath = args['imagePath'];
    final Map<String, dynamic> result = args['result'];

    final bool isHealthy = result['status'] == 'Sehat';
    final bool isError = result['status'] == 'Error';

    // Save to history using controller
    if (!isError) {
      final detection = DetectionResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imagePath: imagePath,
        status: result['status'],
        confidence: result['confidence'],
        disease: result['disease'],
        ripeness: result['ripeness'],
        quality: result['quality'],
        recommendations: List<String>.from(result['recommendations']),
        timestamp: DateTime.now(),
      );
      
      final controller = Get.find<DetectionHistoryController>();
      controller.saveDetection(detection);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D7A4F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Hasil Analisis AI',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () => Get.toNamed('/history'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Preview
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.black,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 16),

            // Status Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isError
                      ? Colors.red.shade50
                      : (isHealthy ? Colors.green.shade50 : Colors.orange.shade50),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isError
                        ? Colors.red
                        : (isHealthy ? Colors.green : Colors.orange),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      isError
                          ? Icons.error_outline
                          : (isHealthy ? Icons.check_circle_outline : Icons.warning_amber),
                      size: 64,
                      color: isError
                          ? Colors.red
                          : (isHealthy ? Colors.green : Colors.orange),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      result['status'] ?? 'Tidak Diketahui',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isError
                            ? Colors.red.shade900
                            : (isHealthy ? Colors.green.shade900 : Colors.orange.shade900),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Confidence: ${result['confidence'].toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Details Card
            if (!isError) ...[
              _buildDetailCard(
                'Informasi Detail',
                [
                  _DetailRow('Penyakit', result['disease'] ?? 'Tidak terdeteksi'),
                  _DetailRow('Kematangan', result['ripeness'] ?? '-'),
                  _DetailRow('Kualitas', result['quality'] ?? '-'),
                ],
              ),

              const SizedBox(height: 16),

              // Recommendations Card
              _buildRecommendationCard(result['recommendations'] ?? []),
            ] else ...[
              // Error message
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.info_outline, size: 48, color: Colors.grey),
                      const SizedBox(height: 12),
                      Text(
                        result['disease'] ?? 'Terjadi kesalahan',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Scan Ulang'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFF2D7A4F), width: 2),
                        foregroundColor: const Color(0xFF2D7A4F),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Get.offAllNamed('/main'),
                      icon: const Icon(Icons.home),
                      label: const Text('Ke Beranda'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF2D7A4F),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, List<_DetailRow> details) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D7A4F),
              ),
            ),
            const SizedBox(height: 16),
            ...details.map((detail) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          detail.label,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          detail.value,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(List<dynamic> recommendations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Color(0xFF2D7A4F)),
                SizedBox(width: 8),
                Text(
                  'Rekomendasi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D7A4F),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (recommendations.isEmpty)
              const Text('Tidak ada rekomendasi')
            else
              ...recommendations.asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D7A4F).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${entry.key + 1}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D7A4F),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            entry.value.toString(),
                            style: const TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}

class _DetailRow {
  final String label;
  final String value;

  _DetailRow(this.label, this.value);
}
