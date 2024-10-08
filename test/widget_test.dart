import 'package:audio_player_/views/onboardingScreen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:audio_player_/main.dart';
import 'package:audio_player_/views/LoginPage.dart';
import 'package:audio_player_/views/HomePage.dart';

void main() {
  group('Navigation Tests', () {
    testWidgets(
        'Login page is displayed when not logged in and onboarding completed',
        (WidgetTester tester) async {
      // Build our app with isLoggedIn set to false and onboarding completed
      await tester
          .pumpWidget(MyApp(isLoggedIn: false, isOnboardingCompleted: true));

      // Verify that the LoginPage is displayed.
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets(
        'Home page is displayed when logged in and onboarding completed',
        (WidgetTester tester) async {
      // Build our app with isLoggedIn set to true and onboarding completed
      await tester
          .pumpWidget(MyApp(isLoggedIn: true, isOnboardingCompleted: true));

      // Verify that the HomeScreen is displayed.
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Onboarding screen is displayed when onboarding not completed',
        (WidgetTester tester) async {
      // Build our app with isOnboardingCompleted set to false
      await tester
          .pumpWidget(MyApp(isLoggedIn: false, isOnboardingCompleted: false));

      // Verify that the OnboardingScreen is displayed.
      expect(find.byType(OnboardingScreen), findsOneWidget);
    });
  });
}
