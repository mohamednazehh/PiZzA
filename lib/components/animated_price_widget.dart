import 'package:flutter/material.dart';

class AnimatedPriceWidget extends StatefulWidget {
  final double? price;

  const AnimatedPriceWidget({
    Key? key,
    this.price,
  }) : super(key: key);

  @override
  _AnimatedPriceWidgetState createState() => _AnimatedPriceWidgetState();
}

class _AnimatedPriceWidgetState extends State<AnimatedPriceWidget>
    with TickerProviderStateMixin {
  double _previousPrice = 0.0;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    final double _currentPrice = widget.price ?? 0.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          // show previous price at controller value 0 and current price at value 1
          double displayablePrice;
          if (_controller.value == 0)
            displayablePrice = _previousPrice;
          else if (_controller.value == 1) {
            displayablePrice = _currentPrice;
            _previousPrice = _currentPrice;
            _controller.reset();
          } else {
            final double incrementalOffset = (_currentPrice - _previousPrice);
            displayablePrice =
                _previousPrice + (incrementalOffset * _controller.value);
          }

          return RichText(
            text: TextSpan(
              text: displayablePrice.toStringAsFixed(3) + " KD",
              /*style: GoogleFonts.domine(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20.0,
              ),*/
            ),
          );
        },
      ),
    );
  }
}
