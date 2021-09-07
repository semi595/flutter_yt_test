import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AsyncTest extends StatefulWidget {
  const AsyncTest({Key? key}) : super(key: key);

  @override
  _AsyncTestState createState() => _AsyncTestState();
}

class _AsyncTestState extends State<AsyncTest> {
  final _inputController = StreamController<int>.broadcast();
  final _scoreController = StreamController<int>.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: StreamBuilder<Object>(
            stream: _scoreController.stream.transform(TallyTransformer()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Score: ${snapshot.data}');
              }
              return Text('Score: 0');
            }),
      ),
      body: Stack(children: [
        ...List.generate(
            5, (index) => Puzzle(_inputController.stream, _scoreController)),
        Align(
          alignment: Alignment.bottomCenter,
          child: KeyPad(_inputController),
        ),
      ]),
    );
  }
}

class TallyTransformer implements StreamTransformer<int, Object> {
  int sum = 0;
  StreamController<int> _controller = StreamController();

  @override
  Stream<Object> bind(Stream<int> stream) {
    stream.listen((event) {
      sum += event;
      _controller.add(sum);
    });
    return _controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);
}

class Puzzle extends StatefulWidget {
  final Stream<int> inputStream;
  final StreamController<int> _scoreStream;

  const Puzzle(this.inputStream, this._scoreStream, {Key? key})
      : super(key: key);

  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  late int a, b;
  late double x;
  late Color color;

  late AnimationController _controller;

  reset({from = 0.0}) {
    a = Random().nextInt(5) + 1;
    b = Random().nextInt(5);
    x = Random().nextDouble() * 300;
    _controller.duration =
        Duration(milliseconds: Random().nextInt(5000) + 5000);
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)][200]!;
    _controller.forward(from: from);
  }

  @override
  initState() {
    _controller = AnimationController(
      vsync: this,
    );
    reset(from: Random().nextDouble());

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        reset();
        widget._scoreStream.add(-3);
      }
    });

    widget.inputStream.listen((int input) {
      if (input == a + b) {
        reset();
        widget._scoreStream.add(5);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Positioned(
            top: 800 * _controller.value - 100,
            left: x,
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                '$a + $b',
                style: TextStyle(fontSize: 24),
              ),
            ),
          );
        });
  }
}

class KeyPad extends StatelessWidget {
  final _controller;

  KeyPad(this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 2 / 1,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          9,
          (index) => TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.primaries[index],
              shape: RoundedRectangleBorder(),
            ),
            child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 24, color: Colors.black87),
            ),
            onPressed: () {
              _controller.add(index + 1);
            },
          ),
        ),
      ),
    );
  }
}
