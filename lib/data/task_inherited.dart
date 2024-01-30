import 'package:flutter/material.dart';
import 'package:flutter_project/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task(
      "Aprender Flutter",
      "https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large",
      4,
    ),
    Task(
      "Wladnelson talk",
      "assets/images/wlad.png",
      5,
    ),
    Task(
      "Malhar",
      "https://tswbike.com/wp-content/uploads/2020/09/108034687_626160478000800_2490880540739582681_n-e1600200953343.jpg",
      3,
    ),
    Task(
      "Meditar",
      "https://manhattanmentalhealthcounseling.com/wp-content/uploads/2019/06/Top-5-Scientific-Findings-on-MeditationMindfulness-881x710.jpeg",
      1,
    ),
    Task(
      "Jogar DOTA",
      "http://cdn.espn.com.br/image/wide/622_c8d2dc89-d887-3b09-80d0-8e83b216d3cb.jpg",
      1,
    ),
  ];

  void newTask(String name, String image, int difficulty) {
    taskList.add(Task(name, image, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
