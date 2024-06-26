import 'package:flutter/material.dart';
import 'package:taskmanager/app.dart';
import 'package:taskmanager/presentation/controllers/auth_controller.dart';

import 'package:taskmanager/presentation/screens/auth/sign_in_screen.dart';
import 'package:taskmanager/presentation/screens/update_profile_screen.dart';
import 'package:taskmanager/presentation/utils/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title: GestureDetector(
      onTap: () {
        Navigator.push(
          TaskManager.navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      child: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  AuthController.userData?.email ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () async {
                await AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(
                    TaskManager.navigatorKey.currentState!.context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    ),
  );
}
