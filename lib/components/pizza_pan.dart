import 'package:flutter/material.dart';

class PizzaPanWidget extends StatelessWidget {
  const PizzaPanWidget({
    Key? key,
    required this.panScale,
    required this.panRotationAngle,
  }) : super(key: key);

  final double panScale;
  final double panRotationAngle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(2, 2, 0.002)
              ..rotateZ(panRotationAngle / 36),
            child: Image.asset("lib/assets/images/bg.png")),
        AnimatedContainer(
          duration: Duration(milliseconds: 1),
          height: 230 * panScale,
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFBC9FA6)
                    .withOpacity((panScale - 0.9).clamp(0.05, 0.1) * 10),
                spreadRadius: 3 * (1 - panScale),
                blurRadius: 20 * (panScale),
                offset: Offset(0, 10), // changes position of shadow
              ),
            ],
          ),
          child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(2, 2, 0.002)
                ..rotateZ(panRotationAngle)
                ..scale(panScale),
              child: Image.asset("lib/assets/images/wooden-pan.png")),
        ),
      ],
    );
  }
}
