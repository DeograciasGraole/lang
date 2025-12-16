import 'package:flutter/material.dart';

class QuizCard extends StatefulWidget {
  final String? question;
  final List<dynamic> options;
  final correctIndex;

  const QuizCard({
    super.key,
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  String? selectedAnswer;

  final colorCorrect = Colors.green;
  final colorWrong = Colors.red;
  final colorDefault = const Color(0xFFF3F4F6); // light grey

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ image banner
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/lessonIcon1.jpg',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              // ✅ question text
              Text(
                widget.question ?? "No question",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3E50),
                ),
              ),

              const SizedBox(height: 30),

              if (selectedAnswer != null)
                Text(
                  selectedAnswer == widget.correctIndex
                      ? "✅ Correct!"
                      : "❌ Wrong! The right answer is '${widget.correctIndex}'.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: selectedAnswer == widget.correctIndex
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              // ✅ Options
              Column(
                children: widget.options.map((option) {
                  Color bgColor = colorDefault;
                  Color borderColor = Colors.transparent;

                  if (selectedAnswer != null) {
                    if (option == widget.correctIndex &&
                        option == selectedAnswer) {
                      bgColor = colorCorrect.withOpacity(0.8);
                      borderColor = Colors.green.shade700;
                    } else if (option == selectedAnswer &&
                        option != widget.correctIndex) {
                      bgColor = colorWrong.withOpacity(0.8);
                      borderColor = Colors.red.shade700;
                    } else if (option == widget.correctIndex) {
                      bgColor = colorCorrect.withOpacity(0.6);
                      borderColor = Colors.green.shade700;
                    }
                  }

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Material(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          if (selectedAnswer == null) {
                            setState(() {
                              selectedAnswer = option;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: borderColor, width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  option.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.volume_down_rounded,
                                color: Color(0xFF4B6584),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),

              // ✅ optional result text after selection
            ],
          ),
        ),
      ),
    );
  }
}
