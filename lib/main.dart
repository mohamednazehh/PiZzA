import 'package:flutter/material.dart';
import 'package:pizza_ordering/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme(
          background: Color(0xFFD9DFF6),
          brightness: Brightness.light,
          error: Color(0xFFFF0000),
          onBackground: Color(0xFF9FA3BF),
          onError: Color(0xFFFFFFFF),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFFFFFFFF),
          onSurface: Color(0xFF9FA3BF),
          primary: Color(0xFF104B5E),
          primaryVariant: Color(0xFF36141A),
          secondary: Color(0xFFE0B234),
          secondaryVariant: Color(0xFFE0B234),
          surface: Color(0xFFD9DFF6),
        ),
        /*textTheme: GoogleFonts.playfairDisplayTextTheme(
          Theme.of(context).textTheme,
        ),*/
      ),
      home: ChoosePizzaScreen(),
    );
  }
}
