import 'package:covid_pandemic/presentation/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:covid_pandemic/presentation/screens/forgotPassword/forgot_password_screen.dart';
import 'package:covid_pandemic/presentation/screens/health/health_screen.dart';
import 'package:covid_pandemic/presentation/screens/home/home_screen.dart';
import 'package:covid_pandemic/presentation/screens/landing/landing_page.dart';
import 'package:covid_pandemic/presentation/screens/signIn/sign_in_screen.dart';
import 'package:covid_pandemic/presentation/screens/signUp/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String landingScreen = '/';
  static const String signInScreen = '/sign-in';
  static const String signUpScreen = '/sign-up';
  static const String forgetPasswordScreen = '/forget-password';
  static const String homeScreen = '/home';
  static const String healthScreen = '/health';
  static const String bottomNavScreen = '/bottom-nav';
  static const String webViewScreen = '/web-view';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingScreen:
        return MaterialPageRoute(builder: (ctx) => const LandingPage());
      case signInScreen:
        return MaterialPageRoute(builder: (ctx) => const SignInScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (ctx) => const SignUpScreen());
      case forgetPasswordScreen:
        return MaterialPageRoute(
            builder: (ctx) => const ForgotPasswordScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (ctx) => const HomeScreen());
      // case webV:
      //   return MaterialPageRoute(builder: (ctx) => const HealthScreen());
      case bottomNavScreen:
        return MaterialPageRoute(builder: (ctx) => const BottomNavScreen());
    }
  }
}
