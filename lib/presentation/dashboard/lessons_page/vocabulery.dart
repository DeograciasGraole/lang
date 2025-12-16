import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VocabularyCard extends StatelessWidget {
  final String targetWord;
  final String translation;
  final String exampleEn;
  final String exampleTr;
  final String imagePath;
  final VoidCallback onPlayAudio;

  const VocabularyCard({
    super.key,
    required this.targetWord,
    required this.translation,
    required this.exampleEn,
    required this.exampleTr,
    required this.imagePath,
    required this.onPlayAudio,
  });

  bool get isNetworkImage =>
      imagePath.startsWith('http') || imagePath.startsWith('https');

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Colors.white,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Image Section
            if (imagePath.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: isNetworkImage
                    ? Image.network(
                        imagePath,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 90,
                          width: 90,
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image, size: 40),
                        ),
                      )
                    : Image.asset(
                        imagePath,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
              )
            else
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.language, size: 40, color: Colors.teal),
              ),

            const SizedBox(width: 16),

            // Word & Translation Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    targetWord,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    translation,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (exampleEn.isNotEmpty && exampleTr.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exampleEn,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          exampleTr,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // Audio Button
            CircleAvatar(
              backgroundColor: Colors.teal.shade100,
              radius: 22,
              child: IconButton(
                icon: const Icon(Icons.volume_up_rounded),
                color: Colors.teal.shade700,
                iconSize: 22,
                onPressed: onPlayAudio,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
