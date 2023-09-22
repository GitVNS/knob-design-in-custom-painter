import 'dart:math';

import 'package:flutter/material.dart';

class KnobPainter extends CustomPainter {
  final int value;
  final double startValue;
  final double endValue;
  KnobPainter(
      {required this.value, required this.startValue, required this.endValue});
  @override
  void paint(Canvas canvas, Size size) {
    var diff = endValue - startValue;
    var multiplier = 265 / (diff + 1);
    var degree = multiplier + (multiplier * value);

    var center = Offset(size.width / 2, size.height / 2);

    //main circle
    canvas.drawCircle(
        center,
        size.width / 2,
        Paint()
          ..shader = LinearGradient(colors: [
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
              .createShader(Rect.fromCenter(
                  center: center, width: size.width, height: size.height)));
    //outer rim
    canvas.drawCircle(
        center,
        (size.width / 2) - size.width * 0.025,
        Paint()
          ..color = const Color(0xff202020)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.05);
    //inner rim
    canvas.drawCircle(
        center,
        (size.width / 2) - size.width * 0.075,
        Paint()
          ..color = const Color(0xff333533)
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.05);

    //indicator
    Paint gradientPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
              colors: [Colors.blue, Colors.yellow],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)
          .createShader(Rect.fromCenter(
              center: center, width: size.width, height: size.height));
    canvas.drawArc(
        Rect.fromCenter(
            center: center,
            width: (size.width) - size.width * 0.1,
            height: (size.width) - size.width * 0.1),
        135 * pi / 180,
        degree * pi / 180,
        false,
        gradientPaint);

    //text
    final textStyle = TextStyle(
        letterSpacing: -3,
        color: Colors.white,
        fontSize: size.width * 0.3,
        fontWeight: FontWeight.w900);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '${(value + startValue).toInt()}°',
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final offset = Offset(center.dx - (textPainter.width / 2),
        center.dy - (textPainter.height / 2));
    textPainter.paint(canvas, offset);

    //outer lines
    final linesPaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final radius = size.width / 1.7;
    const lineCount = 50;
    const angle = 2 * pi / lineCount;
    final lineLength = radius * 0.08;

    for (int i = 0; i < lineCount; i++) {
      final x1 = center.dx + radius * cos(i * angle);
      final y1 = center.dy + radius * sin(i * angle);

      final x2 = center.dx + (radius - lineLength) * cos(i * angle);
      final y2 = center.dy + (radius - lineLength) * sin(i * angle);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linesPaint);
    }
  }

  @override
  bool shouldRepaint(KnobPainter oldDelegate) =>
      value != oldDelegate.value ||
      startValue != oldDelegate.startValue ||
      endValue != oldDelegate.endValue;
}
