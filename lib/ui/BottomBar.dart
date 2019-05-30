import 'package:flutter/material.dart';
import 'package:healthily_v2/ui/Scrollindicator.dart';

class BottomBar extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  BottomBar({
    this.cardCount,
    this.scrollPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Icon(Icons.settings, color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 5.0,
              child: ScrollIndicator(
                cardCount: cardCount,
                scrollPercent: scrollPercent,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}