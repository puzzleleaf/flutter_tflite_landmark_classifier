import 'package:flutter/material.dart';
import 'package:landmark_classifier/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Landmark Classifier',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colors.transparent,
        )
      ),
      home: HomePage(),
    );
  }
}
