import 'package:flutter/material.dart';

class AddtoCartButton extends StatelessWidget {
  const AddtoCartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: CustomPaint(
              painter: CurvePainter(),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.white.withOpacity(0.8),
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.8),
          ])),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primaryVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20)),
              onPressed: () {},
              icon: Icon(Icons.add_shopping_cart_rounded),
              label: Text(
                "ADD TO CART",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.brown;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      0,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
