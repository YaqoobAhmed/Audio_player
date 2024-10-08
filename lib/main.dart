import 'package:audio_player_/controller/SignupController.dart';
import 'package:audio_player_/views/HomePage.dart';
import 'package:audio_player_/views/LoginPage.dart';
import 'package:audio_player_/views/onboardingScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/song_provider.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize SharedPreferences to check login status and onboarding status
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final isOnboardingCompleted = prefs.getBool('isOnboardingCompleted') ??
      false; // Check if onboarding is completed

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SongProvider()),
        ChangeNotifierProvider(create: (context) => SignupController()),
      ],
      child: MyApp(
          isLoggedIn: isLoggedIn, isOnboardingCompleted: isOnboardingCompleted),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool isOnboardingCompleted;

  const MyApp(
      {Key? key, required this.isLoggedIn, required this.isOnboardingCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set initial route
      routes: {
        '/': (context) {
          if (!isOnboardingCompleted) {
            return OnboardingScreen();
          } else {
            // Show Home or Login based on login status
            return isLoggedIn ? const HomeScreen() : LoginPage();
          }
        },
        '/home': (context) => const HomeScreen(),
        '/login': (context) => LoginPage(),
        '/onboarding': (context) =>
            OnboardingScreen(), // Ensure you have an OnboardingScreen
      },
      // Optional: Handle unknown routes
    );
  }
}
