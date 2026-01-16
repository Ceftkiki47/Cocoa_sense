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
  
  late AnimationController _rotationController;
  late AnimationController _particleController;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Rotation animation for background circles
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Particle animation
    _particleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Wave animation
    _waveController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _pulseController.repeat(reverse: true);
    _startDetection();
  }

  Future<void> _startDetection() async {
    final String imagePath = Get.arguments as String;

    try {
      final geminiService = GeminiAIService();
      final result = await geminiService.detectCocoa(imagePath);

      Get.offNamed('/ai-result', arguments: {
        'imagePath': imagePath,
        'result': result,
      });
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Gagal menganalisis: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    _particleController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Gradient Background
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.lerp(
                        const Color(0xFF1a5c3a),
                        const Color(0xFF2D7A4F),
                        (_waveController.value * 2) % 1,
                      )!,
                      const Color(0xFF2D7A4F),
                      Color.lerp(
                        const Color(0xFF3D9A63),
                        const Color(0xFF4DB370),
                        (_waveController.value * 2) % 1,
                      )!,
                    ],
                  ),
                ),
              );
            },
          ),

          // Animated Circles Background
          AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return CustomPaint(
                painter: CircleBackgroundPainter(
                  animation: _rotationController.value,
                ),
                child: Container(),
              );
            },
          ),

          // Floating Particles
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(
                  animation: _particleController.value,
                ),
                child: Container(),
              );
            },
          ),

          // Grid Pattern Overlay
          Opacity(
            opacity: 0.03,
            child: CustomPaint(
              painter: GridPainter(),
              child: Container(),
            ),
          ),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Main Card
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                            BoxShadow(
                              color: const Color(0xFF2D7A4F).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // AI Icon with Lottie Animation
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          const Color(0xFF2D7A4F).withOpacity(0.1),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    child: Lottie.asset(
                                      'assets/animations/AI.json',
                                      height: 180,
                                      width: 180,
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
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 24),

                            // Animated Loading Bar
                            SizedBox(
                              width: 200,
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

                      // Bottom Info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
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
                            SizedBox(width: 8),
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
    );
  }
}

// Custom Painter for Rotating Circles Background
class CircleBackgroundPainter extends CustomPainter {
  final double animation;

  CircleBackgroundPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw multiple rotating circles
    for (int i = 0; i < 5; i++) {
      final radius = 100.0 + (i * 60);
      final opacity = 0.15 - (i * 0.02);
      
      paint.color = Colors.white.withOpacity(opacity);
      
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(animation * 2 * math.pi * (i % 2 == 0 ? 1 : -1));
      canvas.translate(-center.dx, -center.dy);
      
      canvas.drawCircle(center, radius, paint);
      
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CircleBackgroundPainter oldDelegate) =>
      animation != oldDelegate.animation;
}

// Custom Painter for Floating Particles
class ParticlePainter extends CustomPainter {
  final double animation;

  ParticlePainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // Fixed seed for consistency

    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final baseY = random.nextDouble() * size.height;
      final y = baseY + (animation * 100) % size.height;
      final radius = 1.0 + random.nextDouble() * 3;

      if (y < size.height + 50) {
        paint.color = Colors.white.withOpacity(0.2 + random.nextDouble() * 0.3);
        canvas.drawCircle(Offset(x, y % size.height), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) =>
      animation != oldDelegate.animation;
}

// Custom Painter for Grid Pattern
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const spacing = 40.0;

    // Vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}