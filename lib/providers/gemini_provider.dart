import 'package:flutter/material.dart';
import '../services/gemini_service.dart';
import '../models/message_model.dart';

class GeminiProvider extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();

  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String prompt) async {
    _messages.add(Message(text: prompt, isUser: true));
    _isLoading = true;
    notifyListeners();

    // Build chat history in Gemini format
    List<Map<String, String>> chatHistory = _messages.map((message) {
      return {
        "role": message.isUser ? "user" : "model",
        "parts": message.text,
      };
    }).toList();

    final response = await _geminiService.fetchResponseWithMemory(chatHistory);

    _messages.add(Message(text: response, isUser: false));
    _isLoading = false;
    notifyListeners();
  }
}
