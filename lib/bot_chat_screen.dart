import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BotChatScreen extends StatefulWidget {
  final String userMessage;

  const BotChatScreen({super.key, required this.userMessage});

  @override
  State<BotChatScreen> createState() => _BotChatScreenState();
}

class _BotChatScreenState extends State<BotChatScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _chatEnded = false; // Flag to track if chat should stop

  final List<String> _predefinedQuestions = [
    "What is smishing?",
    "How can I detect smishing?",
    "What should I do if I receive a smishing message?",
    "What are some signs of smishing?",
    "Can smishing be harmful?",
    "How can I protect myself from smishing attacks?",
    "What does a typical smishing message look like?"
  ];

  @override
  void initState() {
    super.initState();
    _addUserMessage(widget.userMessage);
    _sendToFlask(widget.userMessage);
  }

  void _addUserMessage(String msg) {
    setState(() {
      _messages.add({'text': msg, 'isUser': true});
    });

    if (_shouldEndChat(msg)) {
      _endChat();
    }
  }

  void _addBotResponse(String msg) {
    if (_chatEnded) return; // Stop further responses

    setState(() {
      _messages.add({'text': msg, 'isUser': false});
      _messages.add({'text': '_options_', 'isUser': false}); // Insert options after bot response
    });
  }

  Future<void> _sendToFlask(String message) async {
    if (_chatEnded) return; // Stop sending if chat is ended

    final url = Uri.parse('http://192.168.1.4:5000/chat');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _addBotResponse(data['response']);
      } else {
        _addBotResponse("⚠️ Server error.");
      }
    } catch (e) {
      _addBotResponse("❌ Could not reach server.");
    }
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty || _chatEnded) return;
    _controller.clear();
    _addUserMessage(text);
    _sendToFlask(text);
  }

  void _handlePredefinedQuestion(String question) {
    if (_chatEnded) return;
    _addUserMessage(question);
    _sendToFlask(question);
  }

  bool _shouldEndChat(String message) {
    final lowerMessage = message.toLowerCase();
    return lowerMessage == "bye" || lowerMessage == "quit";
  }

  void _endChat() {
    setState(() {
      _chatEnded = true;
      _messages.add({'text': "👋 Goodbye! Chat ended.", 'isUser': false});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Row(
          children: [
            Icon(Icons.smart_toy_rounded, color: Colors.white),
            SizedBox(width: 10),
            Text("Bot", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return ChatBubble(
                  text: msg['text'],
                  isUser: msg['isUser'],
                  onOptionSelected: _chatEnded ? null : _handlePredefinedQuestion,
                );
              },
            ),
          ),
          if (!_chatEnded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _handleSend(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.deepPurple),
                    onPressed: _handleSend,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final void Function(String)? onOptionSelected;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (text == '_options_') {
      return Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            "What is smishing?",
            "How can I detect smishing?",
            "What should I do if I receive a smishing message?",
            "What are some signs of smishing?",
            "Can smishing be harmful?",
            "How can I protect myself from smishing attacks?",
            "What does a typical smishing message look like?"
          ].map((question) {
            return ElevatedButton(
              onPressed: onOptionSelected != null ? () => onOptionSelected!(question) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            );
          }).toList(),
        ),
      );
    }

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.deepPurple : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
