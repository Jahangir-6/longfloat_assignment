import 'dart:math';

import 'package:flutter/material.dart';
import '../painters/chat_input_painter.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [
          Stack(
            children: [
              CustomPaint(
                size: const Size(double.infinity, 70),
                painter: FuturisticChatPainter(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white, // Input text color
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Ask something...",
                    hintStyle: TextStyle(
                      color: Colors
                          .white54, // Hint text color (slightly transparent white)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
