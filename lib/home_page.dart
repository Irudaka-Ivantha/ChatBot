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
              margin: const EdgeInsets.only(top: 260.0),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                      'lib/assets/home1.jpg'), // Your background image
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
                    colors: [Color.fromARGB(255, 44, 4, 61), Color(0xFF9C27B0)],
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
                  children: [
                    // Display the image
                    Image.asset(
                      'lib/assets/OIP.jpeg', // Make sure the image path is correct, it should be relative to the 'assets' folder
                      height: 80, // Adjust size as needed
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported,
                            size: 60, color: Colors.white);
                      },
                    ),
                    const SizedBox(height: 20),
                    // Welcome text
                    const Text(
                      'Welcome to PurpleBot',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Assistant description
                    const Text(
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
                        color: const Color.fromARGB(255, 147, 32, 182),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // child: Padding(
                        //   padding: const EdgeInsets.all(24.0),
                        //   child: Column(
                        //     children: [
                        //       const Text(
                        //         'Start chatting with your personal assistant.',
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //           fontSize: 18,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //       const SizedBox(height: 20),
                        //       Image.asset(
                        //         'lib/assets/OIP.jpeg', // Replace with your image file
                        //         height: 80, // Adjust size as needed
                        //         width: 80,
                        //         fit: BoxFit.cover,
                        //         errorBuilder: (context, error, stackTrace) {
                        //           return const Icon(Icons.image_not_supported,
                        //               size: 60, color: Colors.white);
                        //         },
                        //       ),
                        //       const SizedBox(height: 20),
                        //       // const Icon(
                        //       //   Icons.auto_mode,
                        //       //   size: 40,
                        //       //   color: Color.fromARGB(255, 98, 23, 125),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
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
                                const Color.fromARGB(255, 135, 22, 169),
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
