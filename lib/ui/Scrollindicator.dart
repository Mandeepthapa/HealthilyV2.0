import 'package:flutter/material.dart';
import 'package:healthily_v2/ui/ScrollIndicatorPainter.dart';

class ScrollIndicator extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  ScrollIndicator({
    this.cardCount,
    this.scrollPercent,
  });
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScrollIndicatorPainter(
          cardCount: cardCount, scrollPercent: scrollPercent),
      child: Container(),
    );
  }
}
