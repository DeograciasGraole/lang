import 'package:flutter/material.dart';
import 'package:lang/presentation/onboarding/getStarted_screen.dart';
import 'package:lang/presentation/onboarding/onboardingscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardindScreen(),
    );
  }
}
