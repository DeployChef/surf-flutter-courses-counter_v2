import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MegaGesture(),
      ),
    );
  }
}

class MegaGesture extends StatefulWidget {
  const MegaGesture({
    super.key,
  });

  @override
  State<MegaGesture> createState() => _MegaGestureState();
}

class _MegaGestureState extends State<MegaGesture> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? top;
  double? left;
  double angle = 0;
  double height = 50;
  double width = 50;
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    top = top ?? MediaQuery.of(context).size.height / 2 - height / 2;
    left = left ?? MediaQuery.of(context).size.width / 2 - width / 2;

    return ColoredBox(
      color: Colors.brown,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: top,
            left: left,
            height: height,
            width: width,
            child: RotationTransition(
              turns: _animation,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: height,
                width: width,
                color: color,
                alignment: Alignment.center,
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                var generatedColor = Random().nextInt(Colors.primaries.length);
                setState(() {
                  color = Colors.primaries[generatedColor];
                  height = 40.0 + Random().nextInt(30);
                  width = 40.0 + Random().nextInt(30);
                });
              },
              onLongPress: () {
                _controller.reset();
                _controller.forward();
              },
              onHorizontalDragUpdate: _drag,
              onVerticalDragUpdate: _drag,
            ),
          ),
        ],
      ),
    );
  }

  void _drag(DragUpdateDetails details) {
    setState(() {
      left = details.localPosition.dx - width / 2;
      top = details.localPosition.dy - height / 2;
    });
  }
}
