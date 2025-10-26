import 'package:flutter/material.dart';
import 'chat_message.dart';
import 'message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(text: "Hi there!", isSentByMe: false),
    ChatMessage(text: "Hello! How are you?", isSentByMe: true),
    ChatMessage(text: "I'm doing great, thanks for asking!", isSentByMe: false),
    ChatMessage(text: "What have you been up to?", isSentByMe: true),
    ChatMessage(text: "Just working on some Flutter stuff.", isSentByMe: false),
  ];
  final TextEditingController _textController = TextEditingController();

  void _handleSendPressed() {
    if (_textController.text.isNotEmpty) {
      final message = ChatMessage(
        text: _textController.text,
        isSentByMe: true,
      );
      setState(() {
        _messages.add(message);
        _textController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: _messages[index]);
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration.collapsed(
                hintText: "Send a message...",
              ),
              onSubmitted: (value) => _handleSendPressed(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _handleSendPressed,
          ),
        ],
      ),
    );
  }
}
