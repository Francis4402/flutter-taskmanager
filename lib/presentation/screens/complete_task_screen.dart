import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/widgets/task_card.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';
import 'package:taskmanager/presentation/widgets/profile_bar.dart';

class CompleteScreenTask extends StatefulWidget {
  const CompleteScreenTask({super.key});

  @override
  State<CompleteScreenTask> createState() => _CompleteScreenTaskState();
}

class _CompleteScreenTaskState extends State<CompleteScreenTask> {
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


