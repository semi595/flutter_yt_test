import 'package:flutter/material.dart';

class AnimationTest2 extends StatefulWidget {
  const AnimationTest2({Key? key}) : super(key: key);

  @override
  _AnimationTest2State createState() => _AnimationTest2State();
}

class _AnimationTest2State extends State<AnimationTest2>
    with TickerProviderStateMixin {
  late AnimationController _expansionController;
  late AnimationController _opacityController;

  @override
  void initState() {
    super.initState();
    _expansionController =
        AnimationController(duration: Duration(seconds: 4), vsync: this)
          ..repeat(reverse: true);

    _opacityController =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _expansionController.dispose();
    _opacityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 500,
                child: Center(
                  child: FadeTransition(
                    opacity:
                        Tween(begin: 0.5, end: 1.0).animate(_opacityController),
                    child: AnimatedBuilder(
                      animation: _expansionController,
                      builder: (BuildContext context, Widget? child) {
                        return Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            gradient: RadialGradient(colors: [
                              Color(0xFF2196F3),
                              Color(0xFFBBDEFB)
                            ], stops: [
                              _expansionController.value,
                              _expansionController.value + 0.1,
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 500,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    color: Colors.blue[500],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
