import 'package:flutter/material.dart';

class ScrollIndicatorPainter extends CustomPainter {
  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({
    this.cardCount,
    this.scrollPercent,
  })  : trackPaint = new Paint()
          ..color = const Color(0xFF444444)
          ..style = PaintingStyle.fill,
        thumbPaint = new Paint()
          ..color = const Color(0xFFFFFFFF)
          ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        new RRect.fromRectAndCorners(
          new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: Radius.circular(3.0),
          topRight: Radius.circular(3.0),
          bottomLeft: Radius.circular(3.0),
          bottomRight: Radius.circular(3.0),
        ),
        trackPaint);

    //Draw thumb
    final thumbWidth = size.width / cardCount;
    final thumbLeft = scrollPercent * size.width;

    canvas.drawRRect(
        new RRect.fromRectAndCorners(
          new Rect.fromLTWH(thumbLeft, 0.0, thumbWidth, size.height),
          topLeft: Radius.circular(3.0),
          topRight: Radius.circular(3.0),
          bottomLeft: Radius.circular(3.0),
          bottomRight: Radius.circular(3.0),
        ),
        thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
