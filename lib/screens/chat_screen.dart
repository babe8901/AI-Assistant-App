import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/ai_service.dart';
import '../widgets/message_tile.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  final chat = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: 'AIzaSyARzClutx6Aotz1SoQ4GiOQs60A3jCVnxY',
          generationConfig: GenerationConfig(maxOutputTokens: 300))
      .startChat(history: []);

  void _sendMessage() async {
    final messageText = _controller.text;
    setState(() {
      _messages.add(Message(text: messageText, isUser: true));
      _controller.clear();
    });

    final aiResponse = await AIService.getAIResponse(chat, messageText);
    setState(() {
      _messages.add(Message(text: aiResponse, isUser: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat App')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageTile(message: _messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
