import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cocoa_sense/models/detection_result.dart';

class DetectionHistoryService {
  static const String _key = 'detection_history';

  Future<void> saveDetection(DetectionResult result) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();
    history.insert(0, result);
    
    // Limit to 50 recent detections
    if (history.length > 50) {
      history.removeRange(50, history.length);
    }
    
    final jsonList = history.map((e) => e.toJson()).toList();
    await prefs.setString(_key, json.encode(jsonList));
  }

  Future<List<DetectionResult>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    
    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => DetectionResult.fromJson(e)).toList();
  }

  Future<void> deleteDetection(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();
    history.removeWhere((e) => e.id == id);
    
    final jsonList = history.map((e) => e.toJson()).toList();
    await prefs.setString(_key, json.encode(jsonList));
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
