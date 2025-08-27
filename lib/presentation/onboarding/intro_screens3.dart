import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 Illustration at top
              Lottie.asset(
                'assets/images/fly.json', // Replace with your image path
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 40),

              // 🔹 Headline
              const Text(
                "Time is now to fly and start",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 15),

              // 🔹 Description
              const Text(
                "With our app, you can track the real-time process of modules No more waiting.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 Optional indicator dot (static)
            ],
          ),
        ),
      ),
    );
  }
}
