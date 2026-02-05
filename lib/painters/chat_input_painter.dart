// import 'package:flutter/material.dart';

// class ChatInputPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFFEEEEEE)
//       ..style = PaintingStyle.fill;

//     final path = Path();

//     const radius = 20.0;
//     const tailWidth = 15.0;
//     const tailHeight = 10.0;

//     path.moveTo(radius, 0);
//     path.lineTo(size.width - radius, 0);
//     path.quadraticBezierTo(size.width, 0, size.width, radius);
//     path.lineTo(size.width, size.height - radius);
//     path.quadraticBezierTo(
//       size.width,
//       size.height,
//       size.width - radius,
//       size.height,
//     );

//     // Tail
//     path.lineTo(radius + tailWidth, size.height);
//     path.lineTo(radius, size.height + tailHeight);
//     path.lineTo(radius + 5, size.height);

//     path.lineTo(radius, size.height);
//     path.quadraticBezierTo(0, size.height, 0, size.height - radius);
//     path.lineTo(0, radius);
//     path.quadraticBezierTo(0, 0, radius, 0);

//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

import 'dart:ui';
import 'package:flutter/material.dart';

class FuturisticChatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Outer glow
    final glowPaint = Paint()
      ..color = const Color(0xFF4D9FFF).withOpacity(0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 18);

    // Glass gradient
    final glassPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1E1E2E), Color(0xFF151522)],
      ).createShader(rect);

    // Border stroke
    final borderPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF4D9FFF), Color(0xFF9F7BFF)],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final path = _bubblePath(size);

    // Glow
    canvas.drawPath(path, glowPaint);

    // Body
    canvas.drawPath(path, glassPaint);

    // Border
    canvas.drawPath(path, borderPaint);
  }

  Path _bubblePath(Size size) {
    const r = 24.0;
    const tailW = 20.0;
    const tailH = 14.0;

    final path = Path();
    path.moveTo(r, 0);
    path.lineTo(size.width - r, 0);
    path.quadraticBezierTo(size.width, 0, size.width, r);

    path.lineTo(size.width, size.height - r);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );

    path.lineTo(r + tailW, size.height);

    // Futuristic curved tail
    path.cubicTo(
      r + tailW - 4,
      size.height,
      r + tailW - 6,
      size.height + tailH,
      r,
      size.height + tailH,
    );

    path.cubicTo(
      r + 4,
      size.height + tailH,
      r + 6,
      size.height,
      r - 6,
      size.height,
    );

    path.lineTo(r, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - r);
    path.lineTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
