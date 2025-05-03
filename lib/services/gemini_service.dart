import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  static const String systemPrompt = """
You are a compassionate and supportive virtual therapist. 
Always respond with empathy, patience, and kindness. 
Remember the user's previous messages and offer advice, ask gentle questions, 
and help them process their feelings in a caring way. Never break character.
However dont say too many sentences at once.
""";

  Future<String> fetchResponseWithMemory(List<Map<String, String>> chatHistory) async {
    try {
      // Convert chat history to a string format
      final historyText = chatHistory.map((msg) {
        final role = msg["role"] == "user" ? "User" : "Therapist";
        return "$role: ${msg["parts"]}";
      }).join("\n");

      final fullPrompt = "$systemPrompt\n\n$historyText\nTherapist:";

      final response = await Gemini.instance.prompt(parts: [
        Part.text(fullPrompt)
      ]);
      return response?.output ?? 'No response received';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
