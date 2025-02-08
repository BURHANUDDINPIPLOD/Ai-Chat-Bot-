import 'package:flutter/material.dart';
import 'package:myapp/chat/model/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({
  super.key,
  required this.message,});

  @override
  Widget build(BuildContext context) {
    return Align(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3257002093.
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.green : Colors.blueGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(message.content)),
      );
  }
}