import 'package:audio_player_/views/LoginPage.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildPage(
                context,
                'assets/onboarding1.jpg',
                'Welcome to Breathin',
                'Take care of your hives through Breathin',
                height,
                width,
              ),
              _buildPage(
                context,
                'assets/onboarding2.jpg',
                'Relax and Unwind',
                'Find peace with guided meditations',
                height,
                width,
              ),
              _buildPage(
                context,
                'assets/onboarding3.jpg',
                'Enjoy your Music',
                'See how far you’ve come',
                height,
                width,
              ),
            ],
          ),
          Positioned(
            bottom: height * 0.1,
            left: width * 0.5 - 20,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.orangeAccent,
              ),
            ),
          ),
          Positioned(
            top: height * 0.5,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                if (_pageController.page! > 0) {
                  _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
            ),
          ),
          Positioned(
            top: height * 0.5,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: () {
                if (_pageController.page! < 2) {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                } else {
                  // If the user is on the last page, navigate to LoginPage
                  _completeOnboarding(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, String asset, String title,
      String subtitle, double height, double width) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 5),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              if (title == 'Enjoy your Music')
                InkWell(
                  onTap: () {
                    _completeOnboarding(context);
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.orangeAccent,
                    ),
                    child: const Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ],
    );
  }

  // Function to complete onboarding and save status
  Future<void> _completeOnboarding(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'isOnboardingCompleted', true); // Set onboarding completed

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => LoginPage()), // Navigate to LoginPage
    );
  }
}
