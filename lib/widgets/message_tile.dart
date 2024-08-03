import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/message.dart';

class MessageTile extends StatelessWidget {
  final Message message;

  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          decoration: BoxDecoration(
            color: message.isUser ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(8.0),
          // child: Text(
          //   message.text,
          //   style: TextStyle(color: message.isUser ? Colors.white : Colors.black),
          // ),
          child: MarkdownBody(
            data: message.text,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(color: message.isUser ? Colors.white : Colors.black),
            ),
          )),
    );
  }
}
