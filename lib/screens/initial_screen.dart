import 'package:flutter/material.dart';
import 'package:flutter_project/components/task.dart';
import 'package:flutter_project/data/task_dao.dart';
import 'package:flutter_project/data/task_inherited.dart';
import 'package:flutter_project/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;
  int nivelGlobal = 0;
  int nivelMaximoGlobal = 100;
  double percentualGlobal = 0.0;

  void calcularNivelGlobal() {
    final taskList = TaskInherited.of(context).taskList;
    if (taskList.isNotEmpty) {
      int totalProgressoPossivel = 0;
      int progressoAtual = 0;

      for (var task in taskList) {
        totalProgressoPossivel += task.dificuldade * 10;
        progressoAtual += task.nivel;
      }

      percentualGlobal = (progressoAtual / totalProgressoPossivel);
    } else {
      percentualGlobal = 0.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String percentualFormatado =
        '${(percentualGlobal * 100).toStringAsFixed(1)}%';
    return Scaffold(
        appBar: AppBar(
            leading: Center(
              child: Transform.rotate(
                angle: -0.785,
                child: const Text(
                  'Tarefas',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.blue,
            title: Column(
              children: [
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      percentualFormatado,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: percentualGlobal,
                        backgroundColor: Colors.white70,
                        color: Color.fromARGB(255, 56, 56, 56),
                      ),
                    ),
                  ],
                )
              ],
            ),
            actions: [
              IconButton(
                color: Colors.white,
                icon: Icon(Icons.refresh),
                onPressed: calcularNivelGlobal,
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contextNew) =>
                                  FormScreen(taskContext: context)))
                      .then((value) => setState(() {
                            print("Recarregando a tela inicial...");
                          }));
                },
                icon: Icon(Icons.add),
              ),
            ]),
        body: AnimatedOpacity(
            opacity: opacidade ? 1 : 0,
            duration: Duration(seconds: 1),
            child: Padding(
                padding: EdgeInsets.only(top: 8, bottom: 70),
                child: FutureBuilder<List<Task>>(
                    future: TaskDao().findAll(),
                    builder: (context, snapshot) {
                      List<Task>? items = snapshot.data;
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                Text('Carregando...'),
                              ],
                            ),
                          );
                        case ConnectionState.waiting:
                          return Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                Text('Carregando...'),
                              ],
                            ),
                          );
                        case ConnectionState.active:
                          return Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                Text('Carregando...'),
                              ],
                            ),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasData && items != null) {
                            if (items.isNotEmpty) {
                              return ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Task tarefa = items[index];
                                    return tarefa;
                                  });
                            }
                            return Center(
                              child: Column(
                                children: [
                                  Icon(Icons.error_outline, size: 128),
                                  Text(
                                    'Não há nenhuma Tarefa',
                                    style: TextStyle(fontSize: 32),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Text(
                            'Erro ao carregar tarefas',
                          );
                      }
                    }))),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black54,
          onPressed: () {
            setState(() {
              opacidade = !opacidade;
            });
          },
          child: Icon(Icons.remove_red_eye,
              color: opacidade ? Colors.red : Colors.green),
        ));
  }
}
