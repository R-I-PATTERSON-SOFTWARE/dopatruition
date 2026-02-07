import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/features/scan/data/gemini_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // 1. Launch the Window IMMEDIATELY
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(child: Text("App is running! Check Terminal for Brain Test.")),
    ),
  ));

  // 2. Run the Test in the background (so it doesn't crash the window)
  testBrain();
}

Future<void> testBrain() async {
  print("------------------------------------------------");
  print("🧠 CONTACTING THE BRAIN...");
  
  try {
    final brain = GeminiService();
    final result = await brain.analyzeFood(
      "Mountain Dew", 
      "Carbonated Water, High Fructose Corn Syrup, Yellow 5"
    );
    print("✅ SUCCESS! BRAIN SAYS: ${result['headline']}");
  } catch (e) {
    print("❌ ERROR: Could not talk to Brain.");
    print("Details: $e");
  }
  print("------------------------------------------------");
}