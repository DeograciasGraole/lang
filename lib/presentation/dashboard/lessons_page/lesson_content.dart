import 'package:flutter/material.dart';
import 'package:lang/presentation/dashboard/activities/Quiz.dart';
import 'package:lang/presentation/dashboard/activities/cardQuiz.dart';
import 'package:lang/presentation/dashboard/lessons_page/grammr_lesson.dart';
import 'package:lang/presentation/dashboard/lessons_page/vocabulery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool onLastPage = false;
  List<Map> WordVocabilary = [
    {
      "word": "Hello",
      "translation": "Merhaba",
      "image": "assets/images/started1.jpg",
    },
    {
      "word": "Apple",
      "translation": "Elma",
      "image": "assets/images/apple.png",
    },
    {
      "word": "Book",
      "translation": "Kitap",
      "image": "assets/images/started4.jpg",
    },
    {
      "word": "Water",
      "translation": "Su",
      "image": "assets/images/lessonIcon1.jpg",
    },
    {
      "word": "Sun",
      "translation": "Güneş",
      "image": "assets/images/lessonIcon.jpg",
    },
    {"word": "Dog", "translation": "Köpek", "image": "assets/images/basic.jpg"},
    {"word": "Cat", "translation": "Kedi", "image": "assets/images/school.jpg"},
    {"word": "Car", "translation": "Araba", "image": "assets/images/house.jpg"},
    {"word": "House", "translation": "Ev", "image": "assets/images/house.jpg"},
    {
      "word": "School",
      "translation": "Okul",
      "image": "assets/images/school.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 1️⃣ Vocabulary list

    final lessonPages = [
      // Vocabulary cards
      ...WordVocabilary.map(
        (item) => VocabularyCard(
          targetWord: item["translation"]!,
          translation: item["word"]!,
          imagePath: item["image"]!,
          onPlayAudio: () => debugPrint("Play ${item["word"]}"),
        ),
      ),

      // Grammar card
      // const GrammarCard(
      //   title: "Present Simple Tense",
      //   explanation:
      //       "We use 'do/does' for questions.\nE.g., Do you like apples?",
      // ),

      // Quiz card
      // const QuizCard(
      //   question: "What is the plural of 'book'?",
      //   options: ["Books", "Bookes", "Boks"],
      //   correctIndex: 0,
      // ),
    ];

    // 2️⃣ Build lesson pages

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        240,
        248,
        243,
      ), // soft background
      appBar: AppBar(
        title: const Text(
          "Lesson 1 : Beginner",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 210, 223, 234),

        // centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Step text + linear progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Text(
                  //   "Word ${_currentIndex + 1} of ${lessonPages.length}",
                  //   style: const TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentIndex + 1) / lessonPages.length,
                    backgroundColor: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromARGB(255, 255, 106, 106),
                    minHeight: 5,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Main PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;

                    onLastPage = (index == WordVocabilary.length - 1);
                  });
                },
                itemCount: lessonPages.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: lessonPages[index],
                    ),
                  );
                },
              ),
            ),

            onLastPage
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return QuizPage(wordLearn: WordVocabilary);
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 106, 106),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Done',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      print('this is onLast in the next : $onLastPage');
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(61, 69, 182, 192),
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
