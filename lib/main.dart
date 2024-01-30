import 'package:flutter/material.dart';
import 'package:flutter_project/data/task_inherited.dart';
import 'package:flutter_project/screens/initial_screen.dart';
//import 'package:flutter_project/screens/minha_primeira_tela.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: MyFirstWidget(),
        //);
        home: TaskInherited(
          child: InitialScreen(),
        ));
  }
}
