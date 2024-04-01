import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/screens/cancel_task_screen.dart';
import 'package:taskmanager/presentation/screens/complete_task_screen.dart';
import 'package:taskmanager/presentation/screens/new_task_screen.dart';
import 'package:taskmanager/presentation/screens/progress_task_screen.dart';
import 'package:taskmanager/presentation/utils/app_colors.dart';

class MainButtonScreen extends StatefulWidget {
  const MainButtonScreen({super.key});

  @override
  State<MainButtonScreen> createState() => _MainButtonScreenState();
}

class _MainButtonScreenState extends State<MainButtonScreen> {

  int _currentSelectedIndex = 0;

  final List<Widget> _screens = [
    const NewTaskScreen(),
    const CompleteScreenTask(),
    const ProgressTaskScreen(),
    const CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index){
          _currentSelectedIndex = index;
          if(mounted){
            setState(() {

            });
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.file_copy_outlined), label: 'New Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.close_rounded), label: 'Cancelled'),
        ],
      ),
    );
  }
}
