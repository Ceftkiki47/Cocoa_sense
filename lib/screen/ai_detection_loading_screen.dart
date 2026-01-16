import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:cocoa_sense/services/gemini_ai_service.dart';
import 'dart:math' as math;

class AIDetectionLoadingScreen extends StatefulWidget {
  const AIDetectionLoadingScreen({super.key});

  @override
  State<AIDetectionLoadingScreen> createState() => _AIDetectionLoadingScreenState();
}

class _AIDetectionLoadingScreenState extends State<AIDetectionLoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _rotateController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotateController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _pulseController.repeat(reverse: true);
    _rotateController.repeat();
    _startDetection();
  }

  Future<void> _startDetection() async {
    final String imagePath = Get.arguments as String;

    try {
      final geminiService = GeminiAIService();
      final result = await geminiService.detectCocoa(imagePath);

      if (mounted) {
        Get.offNamed('/ai-result', arguments: {
          'imagePath': imagePath,
          'result': result,
        });
      }
    } catch (e) {
      if (mounted) {
        Get.back();
        Get.snackbar(
          'Error',
          'Gagal menganalisis: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1F5A37),
              const Color(0xFF2D7A4F),
              const Color(0xFF3D9A63),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated circles background (optimized)
            ...List.generate(3, (index) {
              return Positioned(
                top: -100 + (index * 150.0),
                right: -100 + (index * 80.0),
                child: AnimatedBuilder(
                  animation: _rotateController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotateController.value * 2 * math.pi * (index % 2 == 0 ? 1 : -1),
                      child: Container(
                        width: 200 + (index * 50.0),
                        height: 200 + (index * 50.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),

            // Main content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Main card
                        Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Lottie with pulse
                              AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            const Color(0xFF2D7A4F).withOpacity(0.15),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                      child: Lottie.asset(
                                        'assets/animations/AI.json',
                                        height: 160,
                                        width: 160,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 24),

                              const Text(
                                'Gemini AI Menganalisis',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D7A4F),
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                'Mohon tunggu sebentar...',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Animated progress bar
                              SizedBox(
                                width: 220,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey.shade200,
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                      Color(0xFF2D7A4F),
                                    ),
                                    minHeight: 8,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF2D7A4F).withOpacity(0.1),
                                      const Color(0xFF3D9A63).withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFF2D7A4F).withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.auto_awesome,
                                      size: 18,
                                      color: Color(0xFF2D7A4F),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Powered by Gemini 2.0 Flash',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Bottom info
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Menganalisis kondisi buah kakao',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
