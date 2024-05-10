import 'package:flutter/material.dart';
import 'package:pizza_ordering/models/addon.dart';

class AddonSelector extends StatefulWidget {
  const AddonSelector({Key? key, this.addons}) : super(key: key);
  final List<Addon>? addons;

  @override
  _AddonSelectorState createState() => _AddonSelectorState();
}

class _AddonSelectorState extends State<AddonSelector> {
  PageController _pageController =
      PageController(viewportFraction: 0.3, initialPage: 2);

  double scrollOffset = 2.0; //should be same as initial page
  double pageindex = 0.0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        scrollOffset = _pageController.page ?? 0.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Addon> _addons = widget.addons ?? [];
    final int currentPage = scrollOffset.round();

    return Container(
      height: 100,
      child: Center(
        child: PageView.builder(
            controller: _pageController,
            itemCount: _addons.length,
            itemBuilder: (BuildContext context, int index) {
              final offsetFromCenter = (scrollOffset - index).abs();
              final scale = (offsetFromCenter / 5).clamp(0.0, 1.0);
              return Transform(
                transform: Matrix4.identity()..scale(1 - scale),
                child: Image.asset(
                  _addons[index].selectionImage ?? "",
                ),
              );
            }),
      ),
    );
  }
}
