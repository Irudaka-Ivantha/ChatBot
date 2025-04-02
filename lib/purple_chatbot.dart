import 'package:flutter/material.dart';

class PurpleChatBot extends StatefulWidget {
  const PurpleChatBot({Key? key}) : super(key: key);

  @override
  _PurpleChatBotState createState() => _PurpleChatBotState();
}

class _PurpleChatBotState extends State<PurpleChatBot> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'text': text, 'isUser': true});
      _messages.add({'text': 'You said: $text', 'isUser': false});
    });
    _controller.clear();
  }

  Widget _buildMessage(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.deepPurple : Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          width: double.infinity,
          child: const Text(
            'PurpleBot 🤖',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.only(top: 10),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[_messages.length - 1 - index];
              return _buildMessage(msg['text'], msg['isUser']);
            },
          ),
        ),
        const Divider(height: 1),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Type your message...',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                color: Colors.deepPurple,
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
