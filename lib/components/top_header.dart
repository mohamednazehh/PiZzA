import 'package:flutter/material.dart';

class TopHeader extends StatefulWidget {
  final String? title;
  final String? description;
  final double offsetFromCenter;

  const TopHeader({
    Key? key,
    this.title,
    this.description,
    this.offsetFromCenter = 1.0,
  }) : super(key: key);

  @override
  _TopHeaderState createState() => _TopHeaderState();
}

class _TopHeaderState extends State<TopHeader> {
  @override
  Widget build(BuildContext context) {
    final double offset =
        -10 * ((widget.offsetFromCenter - 0.5).clamp(0.0, 1.0));
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            //
          },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Opacity(
          opacity: 1 - widget.offsetFromCenter,
          child: Transform(
            transform: Matrix4.identity()..translate(0.0, offset, 0.0),
            child: Column(
              children: [
                Text(
                  widget.title ?? "",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(
                  widget.description ?? "",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryVariant
                            .withOpacity(0.65),
                      ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            //
          },
          icon: Icon(
            Icons.favorite_border,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
