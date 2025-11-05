import 'package:flutter/material.dart';
import 'package:rc_tank_app/start_screen.dart';

//runs app with StartScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
