import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/widgets/task_card.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';
import 'package:taskmanager/presentation/widgets/profile_bar.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
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


