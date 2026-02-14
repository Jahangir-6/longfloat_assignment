import 'package:flutter/material.dart';
import 'android_chat_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Android Chat Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Chat Page')),
        body: const Center(child: AndroidChatInput()),
      ),
    );
  }
}
