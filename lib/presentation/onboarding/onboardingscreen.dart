import 'package:flutter/material.dart';
import 'package:lang/presentation/onboarding/getStarted_screen.dart';
import 'package:lang/presentation/onboarding/intro_screens.dart';
import 'package:lang/presentation/onboarding/intro_screens2.dart';
import 'package:lang/presentation/onboarding/intro_screens3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardindScreen extends StatefulWidget {
  const OnBoardindScreen({super.key});

  @override
  State<OnBoardindScreen> createState() => _OnBoardindScreenState();
}

class _OnBoardindScreenState extends State<OnBoardindScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    //controller to have keep of page we're on

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [IntroPage1(), IntroPage2(), IntroPage3()],
          ),

          //dot indicator
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment(0, 0.87),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     _controller.jumpToPage(2);
                //   },
                //   child: Text('skip'),
                // ),
                SmoothPageIndicator(
                  controller: _controller,
                  //
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.black26,
                    dotHeight: 6,
                  ),
                ),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 106, 106),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(
                            'Done',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ],
            ),
          ),

          // next or done
        ],
      ),
    );
  }
}
