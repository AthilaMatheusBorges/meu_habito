import 'package:flutter/material.dart';

class ButtonPurpple extends StatefulWidget {
  const ButtonPurpple({super.key, required this.name, required this.action});

  final String name;
  final Function action;

  @override
  State<ButtonPurpple> createState() => _ButtonPurpple();
}

class _ButtonPurpple extends State<ButtonPurpple> {
  bool isNovaTarefa = false;

  @override
  Widget build(BuildContext context) {
    if (widget.name == 'Nova Tarefa') isNovaTarefa = true;

    return Container(
      width: 169.0,
      height: 54.0,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment(5.0, 1.0),
              colors: <Color>[Color(0xFF3B45F5), Color(0xFFFFFFFF)]),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(
            onPressed: () {
              widget.action();
            },
            child: Text(widget.name,
                style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'MontSerrat',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold))),
        if (isNovaTarefa)
          Icon(
            Icons.add_circle_outline,
            color: Colors.white,
          )
      ]),
    );
  }
}
