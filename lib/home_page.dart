import 'package:flutter/material.dart';
import 'bot_welcome_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Colors.deepPurple.shade50, // Keeps your background color
        body: Stack(// Use a Stack to layer the gradient and background image
            children: [
          // Background image section (stays behind everything else)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                      'lib/assets/home.jpg'), // Your background image
                  fit: BoxFit
                      .cover, // This ensures the image covers the full screen
                ),
              ),
            ),
          ),

          // Content section with gradient and purple header
          Column(
            children: [
              // Purple Header with Welcome Message
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF7B1FA2), Color(0xFF9C27B0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.chat_bubble_outline,
                        color: Colors.white, size: 60),
                    SizedBox(height: 20),
                    Text(
                      'Welcome to PurpleBot',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your friendly chat assistant',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // White Content Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              const Text(
                                'Start chatting with your personal assistant.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Image.asset(
                                'lib/assets/chatbot.png', // Replace with your image file
                                height: 80, // Adjust size as needed
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image_not_supported,
                                      size: 60, color: Colors.white);
                                },
                              ),
                              const SizedBox(height: 20),
                              // const Icon(
                              //   Icons.auto_mode,
                              //   size: 40,
                              //   color: Color.fromARGB(255, 98, 23, 125),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),

                      // Get Started Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Add navigation here
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor:
                                const Color.fromARGB(255, 147, 32, 182),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}
