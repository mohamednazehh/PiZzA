import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pizza_ordering/components/add_to_cart_button.dart';
import 'package:pizza_ordering/models/addon.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/addon_selector.dart';
import '../components/animated_price_widget.dart';
import '../components/pizza_pan.dart';
import '../components/top_header.dart';
import '../models/pizza.dart';

class ChoosePizzaScreen extends StatefulWidget {
  const ChoosePizzaScreen({Key? key}) : super(key: key);

  @override
  _ChoosePizzaScreenState createState() => _ChoosePizzaScreenState();
}

class _ChoosePizzaScreenState extends State<ChoosePizzaScreen> {
  int selectedVariant = 1;
  final List<String> variants = ["S", "M", "L"];
  List<Addon> _addons = [
    Addon(
      selectionImage: "lib/assets/images/cheese.png",
      toppingsImage: "lib/assets/images/cheese.png",
    ),
    Addon(
      selectionImage: "lib/assets/images/mashroom.png",
      toppingsImage: "lib/assets/images/mashroom.png",
    ),
    Addon(
      selectionImage: "lib/assets/images/tomato.png",
      toppingsImage: "lib/assets/images/tomato.png",
    ),
    Addon(
      selectionImage: "lib/assets/images/corn.png",
      toppingsImage: "lib/assets/images/corn.png",
    ),
    Addon(
      selectionImage: "lib/assets/images/garlic.png",
      toppingsImage: "lib/assets/images/garlic.png",
    ),
  ];
  final List<Pizza> _pizzas = [
    Pizza(
      name: "Greek",
      description: "Spicy pizza with mozzarella",
      price: 3.5,
      image: 'lib/assets/images/pizza1.png',
    ),
    Pizza(
      name: "Veggie",
      description: "Fresh vegitables and cheese",
      price: 3.0,
      image: 'lib/assets/images/pizza2.png',
    ),
    Pizza(
      name: "Italian",
      description: "Tomato souce and chillies",
      price: 4.25,
      image: 'lib/assets/images/pizza3.png',
    ),
    Pizza(
      name: "French",
      description: "Fresh vegitables and cheese",
      price: 3.75,
      image: 'lib/assets/images/pizza4.png',
    )
  ];

  double scrollOffset = 0.0;
  double pageindex = 0.0;

  final PageController _pageController = PageController();

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int currentPage = scrollOffset.round() % _pizzas.length;
    //scroll fraction return 1 on left and 0 on right edges
    final double scrollFraction =
        (scrollOffset - scrollOffset.truncate()).abs();
    final offsetFromCenter = (0.5 - (scrollFraction - 0.5).abs()) * 2;
    final panRotationAngle = scrollOffset / 2;
    final double panScale = (1 - offsetFromCenter).clamp(0.8, 1);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopHeader(
                title: _pizzas[currentPage].name,
                description: _pizzas[currentPage].description,
                offsetFromCenter: offsetFromCenter,
              ),
              SizedBox(height: 24),
              _buildPizzaSwiper(panScale, panRotationAngle),
              _buildSwipeIndicator(context),
              AnimatedPriceWidget(
                price:
                    (_pizzas[currentPage].price ?? 0) + selectedVariant * 0.25,
              ),
              _buildVariantSelector(context),
              AddonSelector(
                addons: _addons,
              ),
              AddtoCartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildVariantSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 18,
                color: Colors.black.withOpacity(0.03),
                spreadRadius: 12,
                offset: Offset(2, 2)),
            BoxShadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.03),
                spreadRadius: 2,
                offset: Offset(2, 2))
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              left: selectedVariant * 60,
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20,
                        color: Color(0xFFBC9FA6).withOpacity(0.4),
                        spreadRadius: 12,
                        offset: Offset(2, 2))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.amber,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: variants
                  .map((e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedVariant = variants.indexOf(e);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: 60,
                          height: 60,
                          color: Colors.transparent,
                          child: Center(
                              child: Text(
                            e,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          )),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSwipeIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 20),
      child: SmoothPageIndicator(
          controller: _pageController, // PageController
          count: _pizzas.length,
          effect: ExpandingDotsEffect(
            dotColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            activeDotColor: Theme.of(context).colorScheme.primary,
            dotHeight: 6,
            dotWidth: 12,
            expansionFactor: 2,
          ), // your preferred effect
          onDotClicked: (index) {}),
    );
  }

  SizedBox _buildPizzaSwiper(double panScale, double panRotationAngle) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: 290 + selectedVariant * 5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PizzaPanWidget(
                      panScale: panScale * 0.9 + selectedVariant * 0.05,
                      panRotationAngle: panRotationAngle),
                  PageView.builder(
                      controller: _pageController,
                      // itemCount: imgList.length,
                      itemBuilder: (context, index) {
                        pageindex = (scrollOffset - index).abs();
                        final rotation = pageindex * pi;
                        final scale = 1 - pageindex;
                        final opacity = (1 - pageindex).clamp(0.0, 1.0);
                        return Opacity(
                          opacity: opacity,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(2, 2, 0.002)
                                  ..rotateZ(-rotation)
                                  ..scale(
                                      scale * 0.99 + selectedVariant * 0.005),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  foregroundImage: AssetImage(
                                      _pizzas[index % _pizzas.length].image ??
                                          ""),
                                  maxRadius: 80 + selectedVariant * 10,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
