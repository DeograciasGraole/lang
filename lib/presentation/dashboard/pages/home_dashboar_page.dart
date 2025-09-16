import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lang/data/firebase/auth_service..dart';
import 'package:lang/presentation/Auth/login.dart';
import 'package:lang/presentation/onboarding/intro_screens2.dart';
import 'package:lang/presentation/onboarding/intro_screens3.dart'
    show IntroPage3;
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../onboarding/intro_screens.dart';

// import 'Module.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> modules = [
    {
      "title": "Basic for Beginner",
      "lesson": "Lesson 1/15",
      "percent": 0.5,
      "image": "Graolang.png",
    },
    {
      "title": "Building Sentences",
      "lesson": "Lesson 2/20",
      "percent": 0.2,
      "image": "grammar.jpg",
    },
    {
      "title": "Everyday Sentences",
      "lesson": "Lesson 5/25",
      "percent": 0.7,
      "image": "module3.jpg",
    },
    {
      "title": "Daily Life & conversation",
      "lesson": "Lesson 3/18",
      "percent": 0.35,
      "image": "module4.jpg",
    },
    {
      "title": "Intermediate Grammar",
      "lesson": "Lesson 4/30",
      "percent": 0.1,
      "image": "basic.jpg",
    },
  ];

  int _selectedIndex = 0;

  // Screens for each tab
  final List<Widget> _screens = [
    Center(child: Text("🏠 Home Screen", style: TextStyle(fontSize: 22))),
    Center(child: Text("📚 Lessons", style: TextStyle(fontSize: 22))),
    Center(child: Text("👤 Profile", style: TextStyle(fontSize: 22))),
    Center(child: Text("⚙️ Settings", style: TextStyle(fontSize: 22))),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                        'Welcome back',
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
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Stack(
              children: [
                SizedBox(
                  height: 230,
                  child: PageView(
                    controller: _controller,
                    children: [
                      // Slide 1
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/Graolang.png"),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromARGB(
                                  119,
                                  92,
                                  147,
                                  243,
                                ).withOpacity(0.1),
                                const Color.fromARGB(
                                  255,
                                  234,
                                  206,
                                  135,
                                ).withOpacity(0.7),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.access_time, // clock icon
                                color: Colors.white,
                                size: 40,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Learn Anytime, Anywhere",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Access lessons on the go and boost your learning journey.",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Slide 2
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/Graolang.png"),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.1),
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.show_chart, // progress icon
                                color: Colors.white,
                                size: 40,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Track Your Progress",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Stay motivated with personalized progress tracking.",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Slide 3
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/started4.jpg"),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.1),
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.emoji_events, // trophy/achievement icon
                                color: Colors.white,
                                size: 40,
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Earn Achievements",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Collect badges and rewards as you learn more!",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            // color: Colors.blueAccent,
            padding: EdgeInsets.only(top: 10, left: 24, right: 24, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unlock Your full',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'communiction ', // normal part
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),

                      TextSpan(
                        text: 'Potential',

                        // highlighted part
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            229,
                            59,
                          ), // background color
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 500,
            height: 510,
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 per row
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 4 / 3, // keeps them balanced
              ),
              itemCount: modules.length,
              itemBuilder: (context, index) {
                final module = modules[index];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 181, 179, 177),
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage('assets/images/${module["image"]}'),
                      fit: BoxFit.cover, // makes image cover entire box
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(
                          0.3,
                        ), // dark overlay for readability
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularPercentIndicator(
                        radius: 30,
                        percent: module["percent"],
                        progressColor: const Color.fromARGB(255, 63, 146, 167),
                        backgroundColor: Colors.grey.shade300,
                        lineWidth: 8,
                        center: Text(
                          "${(module["percent"] * 100).toInt()}%",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        module["title"],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        module["lesson"],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   selectedItemColor: Colors.green,
      //   unselectedItemColor: Colors.grey,
      //   type: BottomNavigationBarType.fixed, // keeps all items visible
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.menu_book),
      //       label: "Lessons",
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: "Settings",
      //     ),
      //   ],
      // ),
      // bottomNavigationBar: Container(
      //   color: const Color.fromARGB(255, 31, 120, 179),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      //     child: GNav(
      //       backgroundColor: const Color.fromARGB(255, 31, 120, 179),
      //       color: Colors.white,
      //       activeColor: const Color.fromARGB(241, 255, 255, 255),
      //       tabBackgroundColor: const Color.fromARGB(65, 66, 66, 66),
      //       gap: 8,
      //       padding: EdgeInsetsGeometry.all(16),
      //       tabs: [
      //         GButton(icon: Icons.home, text: 'Home'),
      //         GButton(icon: Icons.menu_book, text: 'Lesson'),
      //         GButton(icon: Icons.home, text: 'Chat AI'),
      //         GButton(icon: Icons.search, text: 'profile'),
      //       ],
      //     ),
      //   ),
      // ),
      // bottomNavigationBar: Container(
      //   color: const Color.fromARGB(241, 2, 141, 255),
      //   child: CurvedNavigationBar(
      //     buttonBackgroundColor: const Color.fromARGB(61, 0, 204, 255),
      //     backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //     color: const Color.fromARGB(61, 0, 204, 255),
      //     animationDuration: Duration(milliseconds: 300),
      //     index: _selectedIndex,
      //     onTap: (index) {
      //       setState(() {
      //         _selectedIndex = index;
      //       });
      //       print(_selectedIndex);
      //     },

      //     items: [
      //       Icon(Ionicons.home_outline),
      //       Icon(Ionicons.book_outline),
      //       Icon(FontAwesomeIcons.comment),
      //       // Icon(Icons.home),
      //       // Icon(Icons.home),
      //     ],
      //   ),
      // ),
    );
  }
}
