import 'package:custom_painting/painters/chatbot_logo.dart';
import 'package:flutter/material.dart';
import 'widgets/chat_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Image.asset(
                'assets/gifs/screencast_clear.gif',
                width: 300, // optional width
                height: 200, // optional height
                fit: BoxFit.contain, // scale the GIF nicely
              ),
              const TalkingBot(size: 240),

              Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  bottom: 12,
                  right: 8.0,
                ),
                child: ChatInput(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
