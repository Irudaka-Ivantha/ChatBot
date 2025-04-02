import 'package:flutter/material.dart';
import 'bot_chat_screen.dart'; // Import the BotChatScreen

class BotWelcomeScreen extends StatelessWidget {
  const BotWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Text controller for capturing input text
    TextEditingController _controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Column(
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Center(
              child: Icon(Icons.smart_toy_rounded, size: 80, color: Colors.white),
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'How can I help you today?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.deepPurple),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.add, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'I Ask',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) {
                        // When Enter is pressed
                        _navigateToChatScreen(context, _controller.text);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.deepPurple),
                    onPressed: () {
                      // Optional: handle mic click action here
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToChatScreen(BuildContext context, String text) {
    // Push to the BotChatScreen with the input text
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BotChatScreen(userMessage: text), // Pass text to chat screen
      ),
    );
  }
}
