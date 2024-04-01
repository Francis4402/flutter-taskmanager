import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/controllers/auth_controller.dart';
import 'package:taskmanager/presentation/screens/auth/sign_in_screen.dart';
import 'package:taskmanager/presentation/screens/main_button_new_screen.dart';
import 'package:taskmanager/presentation/widgets/app_logo.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    bool isLoggedIn = await AuthController.isLoggedIn();

    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainButtonScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
