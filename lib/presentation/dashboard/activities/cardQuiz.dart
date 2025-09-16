import 'package:flutter/material.dart';

class QuizCard extends StatefulWidget {
  final String? question;
  final List<String> options;
  final correctIndex;

  QuizCard({
    super.key,
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  var selectAnswer = null;
  var colorCorrect = Colors.green;
  var colorDefault = Colors.blueGrey;
  var colorwrong = Colors.red;

  void checkAnswer(selectAnswer, correct) {
    if (selectAnswer == correct) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color.fromARGB(255, 112, 192, 199),
      width: double.infinity,
      height: 580,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ✅ image of the word
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/lessonIcon1.jpg',
              height: 150,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          // ✅ question word
          Text(
            widget.question.toString(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // ✅ Options inline
          ...widget.options.map((item) {
            var bgColor = colorDefault;
            if (selectAnswer != null) {
              if (item == widget.correctIndex && item == selectAnswer) {
                bgColor = colorCorrect;
              } else if (item != widget.correctIndex && item == selectAnswer) {
                bgColor = colorwrong;
              }

              if (item == widget.correctIndex) {
                bgColor = colorCorrect;
              }
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (selectAnswer == null) {
                    selectAnswer = item;
                  }

                  // checkAnswer(selectAnswer, widget.correctIndex);
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: bgColor,
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.toString(), style: TextStyle(fontSize: 18)),
                    Icon(
                      Icons.volume_down,
                      color: const Color.fromARGB(255, 172, 229, 198),
                      size: 27,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          const Spacer(),

          // ✅ Next button
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.symmetric(vertical: 14),
          //   decoration: BoxDecoration(
          //     color: Colors.blueAccent,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: const Text(
          //     "Next",
          //     style: TextStyle(color: Colors.white, fontSize: 18),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
        ],
      ),
    );
  }
}
