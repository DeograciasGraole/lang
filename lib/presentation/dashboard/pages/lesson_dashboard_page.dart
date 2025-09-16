import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lang/data/firebase/auth_service..dart';
import 'package:lang/presentation/dashboard/lessons_page/lesson_content.dart';
import 'package:lang/presentation/dashboard/lessons_page/vocabulery.dart';
import 'package:timeline_tile/timeline_tile.dart';

class LessonScreen extends StatelessWidget {
  LessonScreen({super.key});
  final PageController _controller = PageController();

  List<Widget> lessons_app = [
    MyLessonTile(
      isFirst: true,
      isLast: false,
      isPast: true,
      title: "Lesson 1",
      subtitle: "Introduction to Basics",
      progress: 1.0,
      image: "assets/images/started1.jpg",
    ),
    MyLessonTile(
      isFirst: false,
      isLast: false,
      isPast: true,
      title: "Lesson 2",
      subtitle: "Numbers & Greetings",
      progress: 0.7,
      image: "assets/images/started4.jpg",
    ),
    MyLessonTile(
      isFirst: false,
      isLast: false,
      isPast: false,
      title: "Lesson 3",
      subtitle: "Daily Phrases",
      progress: 0.0,
      locked: true,
      image: "assets/images/started1.jpg",
    ),
    MyLessonTile(
      isFirst: false,
      isLast: false,
      isPast: false,
      title: "Lesson 3",
      subtitle: "Daily Phrases",
      progress: 0.0,
      locked: true,
      image: "assets/images/started1.jpg",
    ),
    MyLessonTile(
      isFirst: false,
      isLast: true,
      isPast: true,
      title: "Lesson 3",
      subtitle: "Daily Phrases",
      progress: 0.5,
      locked: false,
      image: "assets/images/started1.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            // color: const Color.fromARGB(255, 157, 190, 230),
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(100),
            //   bottomRight: Radius.circular(100),
            // ),
          ),

          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.only(
            top: 30,
            left: 8,
            right: 8,
            bottom: 28,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/started.jpg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome your lessons',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 17, 16, 16),
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 30),
                      Text(
                        authService.value.currentUser?.email ??
                            "No User logged in",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 29, 29, 29),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  // try {
                  //   await authService.value.signout();
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) {
                  //         // return LoginScreen();
                  //       },
                  //     ),
                  //   );
                  // } on FirebaseAuthException catch (e) {
                  //   print(e.message);
                  // }
                },
                child: Icon(
                  Ionicons.settings_outline,
                  size: 30,
                  color: const Color.fromARGB(255, 2, 2, 2),
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          // Header section (promo banners)
          Container(
            width: double.infinity,
            height: 220,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // image: DecorationImage(
              //   image: AssetImage("assets/images/lessonIcon.jpg"),
              //   fit: BoxFit.cover,
              // ),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3A7BD5),
                  Color.fromARGB(255, 221, 210, 153),
                ], // beautiful blue gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Left side: text content
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Lesson badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Lesson 1",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "Basic Words and Concepts",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "The journey starts now — enjoy the learning process!",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right side: playful icon
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.school, // 👈 icon for learning
                        size: 40,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 1),
          ...lessons_app.map((lesson) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => LessonPage()),
                );
              },
              child: lesson,
            );
          }),
          // Timeline lessons
        ],
      ),
    );
  }
}

class MyLessonTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String title;
  final String subtitle;
  final String image;
  final double progress;
  final bool locked;

  const MyLessonTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.progress,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 7.0),
      child: SizedBox(
        height: 120,
        child: TimelineTile(
          isFirst: isFirst,
          isLast: isLast,
          beforeLineStyle: LineStyle(
            color: isPast ? Colors.blue : Colors.grey.shade400,
          ),
          indicatorStyle: IndicatorStyle(
            width: 70,
            height: 70,
            indicator: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isPast ? Colors.blue : Colors.grey.shade100,
                  width: 3,
                ),
                color: isPast ? Colors.blue : Colors.grey.shade100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
          ),
          endChild: Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: locked
                  ? Colors.grey.shade300
                  : (isPast ? Colors.blue[100] : Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: locked ? Colors.grey : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: locked ? Colors.grey.shade600 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          locked ? Colors.grey : Colors.blue,
                        ),
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  locked ? Icons.lock : Icons.arrow_forward_ios,
                  size: 20,
                  color: locked ? Colors.grey : Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
