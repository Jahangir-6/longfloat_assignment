import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class TalkingBot extends StatefulWidget {
  final double size;
  final String text;

  const TalkingBot({super.key, this.size = 220, this.text = "CHATBOT"});

  @override
  State<TalkingBot> createState() => _TalkingBotState();
}

class _TalkingBotState extends State<TalkingBot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logoSize = widget.size;
    final textHeight = widget.size * 0.28;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔵 LOGO
        SizedBox(
          width: logoSize,
          height: logoSize,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return CustomPaint(
                painter: TalkingBotPainter(animationValue: _controller.value),
              );
            },
          ),
        ),

        SizedBox(height: widget.size * 0.08),

        // ✨ TEXT BELOW LOGO
        SizedBox(
          width: logoSize * 1.1,
          height: textHeight,
          child: CustomPaint(painter: ChatbotTextPainter(text: widget.text)),
        ),
      ],
    );
  }
}

class TalkingBotPainter extends CustomPainter {
  final double animationValue; // 0 → 1
  TalkingBotPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);

    final pulse = 1 + animationValue * 0.05;
    final rotation = animationValue * 2 * pi;

    // =========================
    // ROTATING AI CORE
    // =========================
    final coreRadius = w * 0.18;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    final coreGlow = Paint()
      ..color = const Color(0xFF6AA9FF).withOpacity(0.6)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, coreRadius * 0.8);

    final corePaint = Paint()
      ..shader = SweepGradient(
        colors: const [Color(0xFF4D9FFF), Color(0xFF9F7BFF), Color(0xFF4D9FFF)],
      ).createShader(Rect.fromCircle(center: center, radius: coreRadius));

    canvas.drawCircle(center, coreRadius, coreGlow);
    canvas.drawCircle(center, coreRadius * 0.9, corePaint);
    canvas.restore();

    // =========================
    // CHAT BUBBLES
    // =========================
    _drawChatBubble(
      canvas,
      Rect.fromCenter(
        center: Offset(w * 0.28, h * 0.5),
        width: w * 0.32,
        height: h * 0.22 * pulse,
      ),
      tailOnRight: true,
      color: const Color(0xFF4D9FFF),
    );

    _drawChatBubble(
      canvas,
      Rect.fromCenter(
        center: Offset(w * 0.72, h * 0.5),
        width: w * 0.32,
        height: h * 0.22 * pulse,
      ),
      tailOnRight: false,
      color: const Color(0xFF9F7BFF),
    );

    // =========================
    // SIGNAL WAVES
    // =========================
    final wavePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.015
      ..color = Colors.white.withOpacity(0.4);

    for (int i = 0; i < 3; i++) {
      final waveRadius = w * (0.12 + i * 0.05 + animationValue * 0.03);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: waveRadius),
        -pi / 4,
        pi / 2,
        false,
        wavePaint,
      );
    }

    // =========================
    // TYPING DOTS
    // =========================
    final dotPaint = Paint()..color = Colors.white70;
    final dotRadius = w * 0.015;

    for (int i = 0; i < 3; i++) {
      final dx = center.dx + (i - 1) * w * 0.06;
      final dy = center.dy + sin(animationValue * 2 * pi + i) * h * 0.03;
      canvas.drawCircle(Offset(dx, dy), dotRadius, dotPaint);
    }
  }

  void _drawChatBubble(
    Canvas canvas,
    Rect rect, {
    required bool tailOnRight,
    required Color color,
  }) {
    final r = rect.height * 0.25;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(r)));

    if (tailOnRight) {
      path.addPolygon([
        Offset(rect.right, rect.center.dy),
        Offset(rect.right + r * 0.8, rect.center.dy + r * 0.5),
        Offset(rect.right, rect.center.dy + r),
      ], true);
    } else {
      path.addPolygon([
        Offset(rect.left, rect.center.dy),
        Offset(rect.left - r * 0.8, rect.center.dy + r * 0.5),
        Offset(rect.left, rect.center.dy + r),
      ], true);
    }

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [color.withOpacity(0.9), color.withOpacity(0.5)],
      ).createShader(rect);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TalkingBotPainter oldDelegate) => true;
}

class ChatbotTextPainter extends CustomPainter {
  final String text;
  ChatbotTextPainter({required this.text});

  @override
  void paint(Canvas canvas, Size size) {
    double fontSize = size.height * 0.8;
    TextPainter painter;

    do {
      painter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [
                  Color(0xFF9F7BFF),
                  Color(0xFF4D9FFF),
                  Color(0xFF6AE3FF),
                ],
              ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Colors.white24,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      painter.layout();
      fontSize -= 1;
    } while (painter.width > size.width && fontSize > 0);

    final offset = Offset(
      (size.width - painter.width) / 2,
      (size.height - painter.height) / 2,
    );

    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
