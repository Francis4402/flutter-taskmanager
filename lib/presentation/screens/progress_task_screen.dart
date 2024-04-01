import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/widgets/task_card.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';
import 'package:taskmanager/presentation/widgets/profile_bar.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index){
            return const TaskCard();
          },
        ),
      ),
    );
  }
}


