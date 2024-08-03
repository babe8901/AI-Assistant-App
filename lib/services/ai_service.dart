import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  static Future<String> getAIResponse(ChatSession chat, String message) async {
    final content = Content.text(message);
    final response = await chat.sendMessage(content);
    return response.text ?? "Model not responding";
  }
}
