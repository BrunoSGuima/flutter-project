import 'package:flutter/material.dart';

class MyFirstWidget extends StatelessWidget {
  const MyFirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 200,
                width: 200,
                color: Colors.red,
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.deepPurpleAccent,
              ),
            ],
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 200,
                width: 200,
                color: Colors.blue,
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                color: Colors.cyan,
              ),
              Container(
                height: 50,
                width: 50,
                color: Colors.pink,
              ),
              Container(
                height: 50,
                width: 50,
                color: Colors.green,
              ),
            ],
          ),
          Container(
            height: 30,
            width: 300,
            color: Colors.amber,
            child: const Text(
              'CONTAINER',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print('Você apertou o botão');
            },
            child: Text(
              'BOTÃO',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
