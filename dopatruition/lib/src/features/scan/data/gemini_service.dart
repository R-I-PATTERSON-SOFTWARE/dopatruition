import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      throw Exception("No API Key found in .env");
    }
    
    // CHANGED: We switched to 'gemini-pro' because 'flash' isn't active on your key yet.
    _model = GenerativeModel(
      model: 'gemini-2.5-flash', 
      apiKey: apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );
  }

  // CHANGED: Verify this says Future<Map<String, dynamic>> NOT Future<String>
  Future<Map<String, dynamic>> analyzeFood(String foodName, String ingredients) async {
    final prompt = '''
    Analyze this food for an ADHD brain.
    Food: $foodName
    Ingredients: $ingredients

    Return JSON:
    {
      "headline": "Short Title",
      "status": "green" | "yellow" | "red",
      "reason": "One sentence explanation."
    }
    ''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      
      // CLEANING: Sometimes AI wraps JSON in ```json ... ```. We remove that.
      String cleanText = response.text ?? "{}";
      cleanText = cleanText.replaceAll('```json', '').replaceAll('```', '').trim();
      
      return jsonDecode(cleanText);
    } catch (e) {
      print("Brain Error: $e");
      return {
        "headline": "Error", 
        "reason": "Could not connect to AI. Check logs.", 
        "status": "red"
      };
    }
  }
}