import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vimigo_assessment/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pagecontroller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _pagecontroller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 3);
            });
          },
          children: [
            Container(
              child: Center(
                child: Image.asset(
                  'assets/images/Group 1.png',
                  width: width,
                  height: height,
                ),
              ),
            ),
            Container(
              child: Center(
                child: Image.asset(
                  'assets/images/Group 2.png',
                  width: width,
                  height: height,
                ),
              ),
            ),
            Container(
              child: Center(
                child: Image.asset(
                  'assets/images/Group 3.png',
                  width: width,
                  height: height,
                ),
              ),
            ),
            Container(
              child: Center(
                child: Image.asset(
                  'assets/images/Group 4.png',
                  width: width,
                  height: height,
                ),
              ),
            ),
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.015, horizontal: width * 0.08),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    shadowColor: Colors.grey[400],
                    elevation: 7,
                  ),
                  onPressed: () {
                    _pagecontroller.jumpToPage(2);
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _pagecontroller,
                  count: 3,
                  effect: WormEffect(
                      dotColor: Colors.white, activeDotColor: Colors.red),
                ),
                onLastPage
                    ? TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.015,
                              horizontal: width * 0.08),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          shadowColor: Colors.grey[400],
                          elevation: 7,
                        ),
                        onPressed: () async {
                          Navigator.pushNamedAndRemoveUntil(
                              context, homePageRoute, ModalRoute.withName('/'));
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ))
                    : TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.015,
                              horizontal: width * 0.08),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          shadowColor: Colors.grey[400],
                          elevation: 7,
                        ),
                        onPressed: () {
                          _pagecontroller.nextPage(
                              duration: const Duration(
                                milliseconds: 500,
                              ),
                              curve: Curves.easeIn);
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
              ],
            )),
      ]),
    );
  }
}
