import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ricky_morty_app/pages/login_page.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.black87,
      duration: 3000,
      splash: Image.asset(
        'assets/images/menu_banner.png',
        width: 600,
        height: 600,
      ),
      splashTransition: SplashTransition.scaleTransition,
      nextScreen: LoginPage(),
    );
  }
}
