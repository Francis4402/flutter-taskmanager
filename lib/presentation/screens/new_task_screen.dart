import 'package:flutter/material.dart';
import 'package:taskmanager/data/count_by_status_wrapper.dart';
import 'package:taskmanager/data/models/task_list_wrapper.dart';
import 'package:taskmanager/data/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';
import 'package:taskmanager/presentation/screens/add_new_task_screen.dart';
import 'package:taskmanager/presentation/widgets/snack_bar_message.dart';
import 'package:taskmanager/presentation/widgets/task_card.dart';
import 'package:taskmanager/presentation/widgets/task_counter_card.dart';
import 'package:taskmanager/presentation/utils/app_colors.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';
import 'package:taskmanager/presentation/widgets/profile_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllTaskCountByStatusProgress = false;
  bool _getNewTaskListInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  TaskListWrapper _newtaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllTaskCountByStatus();
    _getAllNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            Visibility(
                visible: _getAllTaskCountByStatusProgress == false,
                replacement: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                ),
                child: taskCounterSection),
            Expanded(
              child: Visibility(
                visible: _getNewTaskListInProgress = false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                  itemCount: _newtaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return const TaskCard();
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        backgroundColor: AppColors.themeColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get taskCounterSection {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemCount:
                _countByStatusWrapper.listOfTaskByStatusData?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return TaskCounterCard(
                title:
                    _countByStatusWrapper.listOfTaskByStatusData![index].sId ??
                        '',
                amount:
                    _countByStatusWrapper.listOfTaskByStatusData![index].sum ??
                        0,
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(
                width: 8,
              );
            }),
      ),
    );
  }

  Future<void> _getAllTaskCountByStatus() async {
    _getAllTaskCountByStatusProgress = true;

    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);

    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);

      _getAllTaskCountByStatusProgress = false;
      setState(() {});
    } else {
      _getAllTaskCountByStatusProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get task count by status has been failed');
      }
    }
  }

  Future<void> _getAllNewTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.newTaskList);
    if (response.isSuccess) {
      _newtaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getNewTaskListInProgress = false;
      setState(() {});
    } else {
      _getNewTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get new task list has been failed');
      }
    }
  }
}
