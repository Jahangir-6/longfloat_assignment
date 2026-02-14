import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidChatInput extends StatelessWidget {
  const AndroidChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        height: 250,
        child: AndroidView(
          viewType: 'chat_input_view',
          layoutDirection: TextDirection.ltr,
        ),
      );
    }

    // Web/Desktop placeholder
    return SizedBox(
      height: 250,
      child: Center(
        child: Text(
          'Chat input placeholder (Web/Desktop)',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
