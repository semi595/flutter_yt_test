import 'package:flutter/material.dart';

class KeyTest extends StatefulWidget {
  const KeyTest({Key? key}) : super(key: key);

  @override
  _KeyTestState createState() => _KeyTestState();
}

class _KeyTestState extends State<KeyTest> {
  final _colors = [
    Colors.blue[100]!,
    Colors.blue[300]!,
    Colors.blue[500]!,
    Colors.blue[700]!,
    Colors.blue[900]!,
  ];

  int _slot = 0;

  final _globalKey = GlobalKey();

  _shuffle() {
    setState(() {
      _colors.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('key test'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            'Welcome',
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Listener(
              onPointerMove: (event) {
                final x = event.position.dx;
                if (x > (_slot + 1) * Box.width) {
                  if (_slot == _colors.length - 1) return;
                  setState(() {
                    final c = _colors[_slot];
                    _colors[_slot] = _colors[_slot + 1];
                    _colors[_slot + 1] = c;
                    _slot++;
                  });
                } else {
                  if (_slot == 0) return;
                  setState(() {
                    final c = _colors[_slot];
                    _colors[_slot] = _colors[_slot - 1];
                    _colors[_slot - 1] = c;
                    _slot--;
                  });
                }
              },
              child: Stack(
                key: _globalKey,
                children: List.generate(
                  _colors.length,
                  (i) => Box(
                    key: ValueKey(_colors[i]),
                    onDrag: (Color color) {
                      final index = _colors.indexOf(color);
                      final renderBox = (_globalKey.currentContext
                          ?.findRenderObject() as RenderBox);
                      var _offset = renderBox.localToGlobal(Offset.zero).dy;
                      print("on drag $index, stack height = $_offset");
                      _slot = index;
                    },
                    color: _colors[i],
                    x: i * Box.width,
                    y: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _shuffle();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Box extends StatelessWidget {
  static const width = 50.0;
  static const height = 50.0;
  static const margin = 2.0;

  final Color color;
  final double x, y;
  final onDrag;
  const Box(
      {Key? key,
      required this.color,
      required this.x,
      required this.y,
      required this.onDrag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      width: width - margin * 2,
      height: height - margin * 2,
    );

    return AnimatedPositioned(
      duration: Duration(milliseconds: 100),
      top: y,
      left: x,
      child: Draggable(
        onDragStarted: () => onDrag(color),
        child: container,
        feedback: container,
        childWhenDragging: Visibility(
          visible: false,
          child: container,
        ),
      ),
    );
  }
}
