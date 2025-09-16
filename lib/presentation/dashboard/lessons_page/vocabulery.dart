import 'package:flutter/material.dart';

class VocabularyCard extends StatelessWidget {
  final String targetWord; // e.g., "Hello"
  final String translation; // e.g., "Merhaba"
  final String imagePath; // e.g., "assets/hello.png"
  final VoidCallback onPlayAudio;

  const VocabularyCard({
    super.key,
    required this.targetWord,
    required this.translation,
    required this.imagePath,
    required this.onPlayAudio,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Use imagePath here
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(imagePath, height: 150, fit: BoxFit.cover),
            ),

            // Use targetWord and translation here
            Column(
              children: [
                Text(
                  targetWord,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  translation,
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),

            IconButton(
              icon: const Icon(
                Icons.volume_up,
                color: Colors.blueAccent,
                size: 32,
              ),
              onPressed: onPlayAudio,
            ),
          ],
        ),
      ),
    );
  }
}
