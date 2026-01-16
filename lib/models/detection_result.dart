class DetectionResult {
  final String id;
  final String imagePath;
  final String status;
  final double confidence;
  final String? disease;
  final String ripeness;
  final String quality;
  final List<String> recommendations;
  final DateTime timestamp;

  DetectionResult({
    required this.id,
    required this.imagePath,
    required this.status,
    required this.confidence,
    this.disease,
    required this.ripeness,
    required this.quality,
    required this.recommendations,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'imagePath': imagePath,
        'status': status,
        'confidence': confidence,
        'disease': disease,
        'ripeness': ripeness,
        'quality': quality,
        'recommendations': recommendations,
        'timestamp': timestamp.toIso8601String(),
      };

  factory DetectionResult.fromJson(Map<String, dynamic> json) => DetectionResult(
        id: json['id'] as String,
        imagePath: json['imagePath'] as String,
        status: json['status'] as String,
        confidence: (json['confidence'] as num).toDouble(),
        disease: json['disease'] as String?,
        ripeness: json['ripeness'] as String,
        quality: json['quality'] as String,
        recommendations: (json['recommendations'] as List).map((e) => e.toString()).toList(),
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
}
