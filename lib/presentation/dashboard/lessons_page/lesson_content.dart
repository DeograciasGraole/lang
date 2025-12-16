import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lang/data/providers/LessonProvider.dart';
import 'package:lang/data/providers/lessonContent.dart';

import 'package:lang/presentation/dashboard/activities/Quiz.dart';
import 'package:lang/presentation/dashboard/activities/cardQuiz.dart';
import 'package:lang/presentation/dashboard/lessons_page/grammr_lesson.dart';
import 'package:lang/presentation/dashboard/lessons_page/vocabulery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LessonPage extends ConsumerStatefulWidget {
  final int lessonId;
  final int idUnit;
  const LessonPage({super.key, required this.lessonId, required this.idUnit});

  @override
  ConsumerState<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends ConsumerState<LessonPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    final lessonsContent = ref.watch(
      lessonsContentProvider((widget.idUnit, widget.lessonId)),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 248, 243),
      appBar: AppBar(
        title: const Text(
          "Lesson 1 : Beginner",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 210, 223, 234),
        elevation: 0,
      ),
      body: lessonsContent.when(
        data: (contents) {
          // if (contents.isEmpty) {
          //   return const Center(
          //     child: Text(
          //       "There are no lessons yet. They will be uploaded soon.",
          //     ),
          //   );
          // }
          final lesson = contents.first;

          // Build vocabPages dynamically from API
          final vocabPages = lesson.vocabularies
              .map(
                (vocab) => VocabularyCard(
                  targetWord: vocab.wordEn,
                  translation: vocab.wordTr,
                  imagePath: vocab.image ?? "assets/images/basic.jpg",
                  exampleEn: vocab.exampleEn,
                  exampleTr: vocab.exampleTr,
                  onPlayAudio: () => debugPrint("Play ${vocab.wordEn}"),
                ),
              )
              .toList();

          return vocabPages.isEmpty
              ? Center(
                  child: Text(
                    "There are no lessons yet. They will be uploaded soon.",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),

                      // Progress bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: LinearProgressIndicator(
                          value: vocabPages.isEmpty
                              ? 0.0
                              : (_currentIndex + 1) / vocabPages.length,
                          backgroundColor: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 106, 181, 255),
                          minHeight: 5,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // PageView for vocab
                      SizedBox(
                        height: 300,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: vocabPages.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                              onLastPage = index == vocabPages.length - 1;
                            });
                          },
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 18,
                            ),
                            child: vocabPages[index],
                          ),
                        ),
                      ),

                      // Next / Done button
                      GestureDetector(
                        onTap: () async {
                          if (onLastPage) {
                            // Navigate to your QuizPage

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizPage(
                                  QuizListQuestion: lesson.quizzes,
                                  lesson_current: widget.lessonId,
                                  unit_current: widget.idUnit,
                                ),
                              ),
                            );
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        child: Container(
                          width: 300,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: onLastPage
                                ? const Color.fromARGB(255, 106, 133, 255)
                                : const Color.fromARGB(61, 69, 182, 192),
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              onLastPage ? 'Done' : 'Next',
                              style: TextStyle(
                                color: onLastPage
                                    ? Colors.white
                                    : const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Error: $error")),
      ),
    );
  }
}
