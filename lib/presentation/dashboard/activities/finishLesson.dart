import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lang/data/models/lessons_model.dart';
import 'package:lang/data/providers/LessonProvider.dart';
import 'package:lang/data/providers/UnitProvider.dart';
import 'package:lang/data/providers/userprogress.dart';
import 'package:lang/presentation/dashboard/dashboard.dart';
import 'package:lang/presentation/dashboard/pages/home_dashboar_page.dart';
import 'package:lottie/lottie.dart';
import 'package:confetti/confetti.dart';

class FinishLessonPage extends ConsumerStatefulWidget {
  final int currentUnit;
  final int currentLesson;

  const FinishLessonPage({
    super.key,
    required this.currentLesson,
    required this.currentUnit,
  });

  @override
  ConsumerState<FinishLessonPage> createState() => _FinishLessonPageState();
}

class _FinishLessonPageState extends ConsumerState<FinishLessonPage> {
  late ConfettiController _confettiController;
  bool isUnitCompleted = false; // Track if unit is completed

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Confetti animation
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
          ),

          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Lottie success animation
              Center(
                child: Lottie.asset('assets/images/Success.json', height: 300),
              ),

              const SizedBox(height: 20),

              // Dynamic message
              Text(
                isUnitCompleted ? "Unit Completed! 🎯" : "Lesson Completed!",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                isUnitCompleted
                    ? "Amazing! You’ve completed all lessons in this unit 🎉"
                    : "Great job finishing this lesson! 🎓",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () async {
                  final currentLesson = widget.currentLesson;
                  final currentUnit = widget.currentUnit;

                  // 1️⃣ Mark current lesson as completed
                  await ref.read(
                    userProgressProvider(
                      UserProgressParams(
                        lessonId: currentLesson,
                        completed: true,
                        percentage: 100,
                      ),
                    ).future,
                  );

                  // 2️⃣ Get all lessons in the unit
                  final lessons = await ref.read(
                    lessonsByUnitProvider(currentUnit).future,
                  );

                  // 3️⃣ Find the last lesson order dynamically
                  final lastLessonOrder = lessons
                      .map((l) => l.order)
                      .reduce((a, b) => a > b ? a : b);

                  // 4️⃣ Unlock next lesson if not last
                  if (currentLesson < lastLessonOrder) {
                    final nextLesson = lessons.firstWhere(
                      (l) => l.order == currentLesson + 1,
                    );

                    // Only unlock if locked (progressPercentage is null)
                    if (nextLesson.progressPercentage == null) {
                      await ref.read(
                        userProgressProvider(
                          UserProgressParams(
                            lessonId: nextLesson.id,
                            completed: false,
                            percentage: 0,
                          ),
                        ).future,
                      );
                    }
                  } else {
                    // 🎯 Last lesson completed — mark unit completed
                    await ref.read(
                      userProgressProvider(
                        UserProgressParams(
                          lessonId: currentUnit, // unit
                          completed: true,
                          percentage: 100,
                        ),
                      ).future,
                    );

                    setState(() {
                      isUnitCompleted = true;
                    });
                  }

                  // 5️⃣ Refresh unit and lesson providers
                  ref.invalidate(unitsProvider);
                  ref.invalidate(lessonsByUnitProvider);

                  // 6️⃣ Navigate back after short delay
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => MainDashboard()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
