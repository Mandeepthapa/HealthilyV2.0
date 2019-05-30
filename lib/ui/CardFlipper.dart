import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:healthily_v2/card_data.dart';
import 'package:healthily_v2/ui/Card.dart';

class CardFlipper extends StatefulWidget {
  final List<CardViewModel> cards;
  final Function(double scrollPercent) onScroll;

  CardFlipper({this.cards, this.onScroll});
  @override
  _CardFlipperState createState() => _CardFlipperState();
}

class _CardFlipperState extends State<CardFlipper>
    with TickerProviderStateMixin {
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;

  @override
  void initState() {
    super.initState();

    finishScrollController = new AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )..addListener(() {
        setState(() {
          scrollPercent = lerpDouble(
              finishScrollStart, finishScrollEnd, finishScrollController.value);
          if (widget.onScroll != null) {
            widget.onScroll(scrollPercent);
          }
        });
      });
  }

  @override
  void dispose() {
    finishScrollController.dispose();
    super.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    final singleCardDragPercent = dragDistance / context.size.width;
    setState(() {
      scrollPercent = (startDragPercentScroll +
              (-singleCardDragPercent / widget.cards.length))
          .clamp(0.0, 1.0 - (1 / widget.cards.length));

      if (widget.onScroll != null) {
        widget.onScroll(scrollPercent);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    finishScrollStart = scrollPercent;
    finishScrollEnd =
        (scrollPercent * widget.cards.length).round() / widget.cards.length;
    finishScrollController.forward(from: 0.0);
    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }

  List<Widget> _buildCards() {
    final cardCount = widget.cards.length;

    int index = -1;
    return widget.cards.map((CardViewModel viewModel) {
      ++index;
      return _buildCard(viewModel, index, cardCount, scrollPercent);
    }).toList();
    // return[
    //   _buildCard(0, widget.cards.length, scrollPercent),
    //   _buildCard(1, widget.cards.length, scrollPercent),
    //   _buildCard(2, widget.cards.length, scrollPercent),
    //   _buildCard(3, widget.cards.length, scrollPercent),

    // ];
  }

  Widget _buildCard(CardViewModel viewModel, int cardIndex, int cardCount,
      double scrollPercent) {
    final cardScrollPercent = scrollPercent / (1 / cardCount);
    // final parallax = scrollPercent-(cardIndex-cardCount);

    return FractionalTranslation(
        translation: Offset(cardIndex - cardScrollPercent, 0.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: new Card1(
            viewModel: viewModel,
            // parallaxPercent:parallax,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: _buildCards(),
      ),
    );
  }
}