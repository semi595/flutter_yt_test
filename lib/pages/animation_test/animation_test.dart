import 'package:flutter/material.dart';
import 'package:test_yt/widgets/animated_counter.dart';

class AnimationTest extends StatefulWidget {
  const AnimationTest({Key? key}) : super(key: key);

  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Test'),
      ),
      // body: _animation1(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _animation1(),
            SildingBox(
                controller: _controller,
                color: Colors.blue[100],
                interval: Interval(0.0, 0.2)),
            SildingBox(
                controller: _controller,
                color: Colors.blue[300],
                interval: Interval(0.2, 0.4)),
            SildingBox(
                controller: _controller,
                color: Colors.blue[500],
                interval: Interval(0.4, 0.6)),
            SildingBox(
                controller: _controller,
                color: Colors.blue[700],
                interval: Interval(0.6, 0.8)),
            SildingBox(
                controller: _controller,
                color: Colors.blue[900],
                interval: Interval(0.8, 1.0)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _animation1() {
    return Center(
      child: Container(
        width: 300,
        height: 20,
        child: AnimatedCounter(
          duration: Duration(milliseconds: 500),
          value: _counter,
        ),
      ),
    );
  }
}

class SildingBox extends StatelessWidget {
  final Color _color;
  final Interval _interval;
  final AnimationController _controller;

  const SildingBox({
    Key? key,
    required AnimationController controller,
    required Interval interval,
    required color,
  })  : _controller = controller,
        _color = color,
        _interval = interval,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: Offset(0.1, 0))
          .chain(CurveTween(curve: Curves.bounceOut))
          .chain(CurveTween(curve: _interval))
          .animate(_controller),
      child: Container(width: 300, height: 100, color: _color),
    );
  }
}
