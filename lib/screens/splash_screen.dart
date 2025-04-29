import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'onboarding_view/onboarding_screen1.dart'; // الانتقال إلى شاشة Onboarding

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: SvgPicture.asset(
        "assets/images/logo.svg",
        width: 150,
      ),
      nextScreen: const OnboardingScreen(), // الانتقال إلى OnboardingScreen1
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000, // 3 ثواني
    );
  }
}
