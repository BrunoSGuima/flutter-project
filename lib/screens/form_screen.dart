import 'package:flutter/material.dart';
import 'package:flutter_project/components/task.dart';
import 'package:flutter_project/data/task_dao.dart';
//import 'package:flutter_project/data/task_inherited.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});

  @override
  State<FormScreen> createState() => _FormScreenState();

  final BuildContext taskContext;
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool dificcultyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    int? parsedValue = int.tryParse(value);
    if (parsedValue == null || parsedValue < 1 || parsedValue > 5) {
      return true;
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.white),
            title: const Text(
              'Nova Tarefa',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                height: 620,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return 'Por favor, insira um nome.';
                          }
                          return null;
                        },
                        controller: nameController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.title),
                          hintText: 'Nome',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (dificcultyValidator(value)) {
                            return 'Por favor, insira uma dificuldade entre 1 e 5.';
                          }
                          return null;
                        },
                        controller: difficultyController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.star),
                          hintText: 'Dificuldade',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {});
                        },
                        keyboardType: TextInputType.url,
                        validator: (value) {
                          if (valueValidator(value)) {
                            return 'Por favor, insira uma URL de imagem.';
                          }
                          return null;
                        },
                        controller: imageController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.image),
                          hintText: 'Imagem',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 72,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageController.text,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'assets/images/nophoto.png',
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Tarefa adicionada com sucesso!'),
                            ),
                          );
                          Navigator.pop(context);
                          //Navigator.of(context).pushNamed('/InitialScreen');
                        }
                        TaskDao().save(Task(
                          nameController.text,
                          imageController.text,
                          int.parse(difficultyController.text),
                        ));
                        // (NÃO USO MAIS) TaskInherited.of(widget.taskContext).newTask(
                        //     nameController.text,
                        //     imageController.text,
                        //     int.parse(difficultyController.text));
                        // print(nameController);
                        // print(difficultyController);
                        // print(imageController);
                      },
                      child: Text('Adicionar'),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
