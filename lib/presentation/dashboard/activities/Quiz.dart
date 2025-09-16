import 'package:flutter/material.dart';
import 'package:lang/presentation/dashboard/activities/cardQuiz.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//comment
class QuizPage extends StatefulWidget {
  QuizPage({super.key, required wordLearn});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool OnLastPage = false;
  final List<Map<String, dynamic>> quizVocabulary = [
    {
      "question": "What is the Turkish word for 'Apple'?",
      "options": ["Elma", "Armut", "Muz", "Portakal"],
      "answer": "Elma",
    },
    {
      "question": "What is the Turkish word for 'Book'?",
      "options": ["Kalem", "Kitap", "Defter", "Okul"],
      "answer": "Kitap",
    },
    {
      "question": "What is the Turkish word for 'School'?",
      "options": ["Ev", "Sınıf", "Okul", "Ders"],
      "answer": "Okul",
    },
    {
      "question": "What is the Turkish word for 'Water'?",
      "options": ["Su", "Çay", "Kahve", "Süt"],
      "answer": "Su",
    },
    {
      "question": "What is the Turkish word for 'Friend'?",
      "options": ["Aile", "Arkadaş", "Düşman", "Komşu"],
      "answer": "Arkadaş",
    },
  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                if (value == 2) {
                  OnLastPage = true;
                  print("is not 2 but 3");
                }
              });
            },
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Center(
                child: QuizCard(
                  question: quizVocabulary[0]['question'],
                  options: quizVocabulary[0]['options'],
                  correctIndex: quizVocabulary[0]['answer'],
                ),
              ),
              Center(
                child: QuizCard(
                  question: quizVocabulary[1]['question'],
                  options: quizVocabulary[1]['options'],
                  correctIndex: quizVocabulary[1]['answer'],
                ),
              ),
              Center(
                child: QuizCard(
                  question: quizVocabulary[2]['question'],
                  options: quizVocabulary[2]['options'],
                  correctIndex: quizVocabulary[2]['answer'],
                ),
              ),

              // Center(
              //   child: QuizCard(
              //     question: null,
              //     options: null,
              //     correctIndex: null,
              //   ),
              // ),
              // Center(
              //   child: QuizCard(
              //     question: null,
              //     options: null,
              //     correctIndex: null,
              //   ),
              // ),
            ],
          ),
          Positioned(
            // top: 12,
            bottom: 100,
            right: 30,
            child: (OnLastPage)
                ? GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      width: 105,
                      height: 50,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 50, 50, 50),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      width: 105,
                      height: 50,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 50, 50, 50),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
