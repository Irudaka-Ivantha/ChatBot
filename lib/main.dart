import 'package:flutter/material.dart';
import 'purple_chatbot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Purple ChatBot',
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      home: const Scaffold(
        body: SafeArea(child: PurpleChatBot()),
      ),
    );
  }
}
