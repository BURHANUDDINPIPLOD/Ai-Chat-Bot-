import 'package:flutter/material.dart';
import 'package:myapp/chat/presentation/chat_bubble.dart';
import 'package:myapp/chat/presentation/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController(); // Fixed variable name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  if (chatProvider.messages.isEmpty) {
                    return const Center(child: Text('Start a Convo'));
                  }
                  return ListView.builder(
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messages[index];
                      return ChatBubble(message: message,);
                    },
                  );
                },
              ),
            ),
            Consumer<ChatProvider>(
              builder: (context, chatProvider, child){
              return Visibility(
                visible: chatProvider.isLoading,
                child: const LinearProgressIndicator(),
              );
            }),
            // Fixed: Removed duplicate Row and corrected controller reference
            Row(
              children: [
                Expanded(
                  child: TextField(controller: _controller), // Corrected controller reference
                ),
                IconButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      final chatProvider = context.read<ChatProvider>();
                      chatProvider.sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}