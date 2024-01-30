import 'package:flutter/material.dart';
import 'package:flutter_project/components/difficulty.dart';
import 'package:flutter_project/data/task_dao.dart';

// ignore: must_be_immutable
class Task extends StatefulWidget {
  final String nome;
  final String imagem;
  final int dificuldade;
  Task(this.nome, this.imagem, this.dificuldade, {super.key});
  int nivel = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  Color barColor = Colors.blue;
  int nivelMaxTimes = 1;

  @override
  Widget build(BuildContext context) {
    bool isUrl = widget.imagem.contains("http");
    int nivelMax = widget.dificuldade * 10;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: barColor,
            ),
            height: 140,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26,
                        ),
                        width: 72,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: isUrl
                              ? Image.network(
                                  widget.imagem,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  widget.imagem,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            width: 200,
                            child: Text(widget.nome,
                                style: TextStyle(
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                          Difficulty(difficultyLevel: widget.dificuldade)
                        ],
                      ),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Accept?"),
                                  content: Text(
                                      "Are you sure you want to delete this task?"),
                                  actions: [
                                    TextButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        TaskDao().delete(widget.nome);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                  elevation: 24.0,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.90),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                );
                              },
                            );
                          },
                          onPressed: () {
                            setState(() {
                              if (nivelMaxTimes <= 4 &&
                                  widget.nivel < nivelMax) {
                                widget.nivel++;
                              } else if (nivelMaxTimes < 4 &&
                                  widget.nivel == nivelMax) {
                                widget.nivel = 0;
                                nivelMaxTimes++;
                                if (nivelMaxTimes == 2) {
                                  barColor = Colors.purple;
                                } else if (nivelMaxTimes == 3) {
                                  barColor = Colors.brown;
                                } else if (nivelMaxTimes == 4) {
                                  barColor = Colors.yellow;
                                }
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_drop_up, color: Colors.white),
                              Text(
                                "Up",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Color.fromARGB(255, 56, 56, 56),
                        value: (widget.dificuldade > 0)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Nivel ${widget.nivel}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
