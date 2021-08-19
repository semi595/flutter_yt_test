import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter(
      {Key? key,
      this.fontSize = 16,
      required int value,
      required Duration duration})
      : _counter = value,
        _duration = duration,
        super(key: key);

  final int _counter;
  final Duration _duration;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: _duration,
      tween: Tween(end: _counter.toDouble()),
      builder: (BuildContext context, double value, Widget? child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        return Stack(
          children: [
            Positioned(
              top: -fontSize * decimal, // 0 -> 100
              child: Opacity(
                opacity: 1.0 - decimal,
                child: Text(
                  '$whole',
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            ),
            Positioned(
              top: fontSize - decimal * fontSize, // 100 -> 0
              child: Opacity(
                opacity: decimal,
                child: Text(
                  '${whole + 1}',
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
