import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lang/presentation/dashboard/pages/chat_dashboard_page.dart';
import 'package:lang/presentation/dashboard/pages/home_dashboar_page.dart';
import 'package:lang/presentation/dashboard/pages/lesson_dashboard_page.dart';

class maindashboard extends StatefulWidget {
  const maindashboard({super.key});

  @override
  State<maindashboard> createState() => _maindashboardState();
}

class _maindashboardState extends State<maindashboard> {
  int _selectedIndex = 0;

  // Screens for each tab
  final List<Widget> _screens = [
    Center(child: Text("🏠 Home Screen", style: TextStyle(fontSize: 22))),
    Center(child: Text("📚 Lessons", style: TextStyle(fontSize: 22))),
    Center(child: Text("👤 Profile", style: TextStyle(fontSize: 22))),
    Center(child: Text("⚙️ Settings", style: TextStyle(fontSize: 22))),
  ];
  final List<Widget> _ScreenPage = [
    DashboardScreen(),
    LessonScreen(),
    ChatScreen(),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: _ScreenPage[_selectedIndex],
      // extendBody: true,
      bottomNavigationBar: Container(
        color: const Color.fromARGB(241, 2, 141, 255),
        child: CurvedNavigationBar(
          buttonBackgroundColor: const Color.fromARGB(61, 0, 204, 255),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          color: const Color.fromARGB(61, 0, 204, 255),
          animationDuration: Duration(milliseconds: 300),
          index: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            print(_selectedIndex);
          },

          items: [
            Icon(Ionicons.home_outline),
            Icon(Ionicons.book_outline),
            Icon(FontAwesomeIcons.comment),
            // Icon(Icons.home),
            // Icon(Icons.home),
          ],
        ),
      ),
    );
  }
}
