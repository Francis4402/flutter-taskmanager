import 'package:flutter/material.dart';
import 'package:taskmanager/data/login_response.dart';
import 'package:taskmanager/data/network_caller.dart';
import 'package:taskmanager/data/response_object.dart';
import 'package:taskmanager/data/utility/urls.dart';
import 'package:taskmanager/presentation/controllers/auth_controller.dart';
import 'package:taskmanager/presentation/screens/auth/email.verification_screen.dart';
import 'package:taskmanager/presentation/screens/main_button_new_screen.dart';
import 'package:taskmanager/presentation/screens/auth/sign_up_screen.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';
import 'package:taskmanager/presentation/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isloginProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your password';
                      }
                      if (value!.length <= 6) {
                        return 'Password should more than 6 letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isloginProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          _signIn();
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EmailVerificationScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        ('Forgot Password ?'),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text('Sign up'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    _isloginProgress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.login, inputParams, fromSignIn: true);

    _isloginProgress = false;
    setState(() {});

    if (response.isSuccess) {
      if (!mounted) {
        return;
      }

      LoginResponse loginResponse =
          LoginResponse.fromJson(response.responseBody);

      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.token!);

      if(mounted){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainButtonScreen()),
                (route) => false);
      }

    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Login failed! try again');
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
