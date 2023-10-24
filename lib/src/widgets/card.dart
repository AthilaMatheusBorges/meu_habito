import 'package:flutter/material.dart';
import 'package:meu_habito/models/tarefa_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/tasks.dart';


class MyCard extends StatefulWidget {
  const MyCard({super.key,
      required this.tarefa,  required this.edit});

  //final setCard;
  final Tarefa tarefa;
  final edit;

  @override
  State<MyCard> createState() => _MyCard();
}

class _MyCard extends State<MyCard> {
  
  
  @override
  Widget build(BuildContext context) {
    Tarefa tarefa = widget.tarefa;
    bool _checked = tarefa.checked;
    bool editCard = widget.edit;

    final Tarefas tasks = Provider.of(context, listen: false);
    toque(){
      if(editCard){

          }else{
              tasks.checkedTask(tarefa.id);
          };
    }


    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 100.0,
      child: GestureDetector(
        onTap: toque,
        child: Card(
          margin: EdgeInsets.only(bottom: 20.0),
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              color: _checked
                  ? Color(0xFF2AA50C)
                  : Color.fromARGB(255, 196, 197, 197),
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _checked ? Color(0xFF2AA50C) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _checked
                        ? Color(0xFF2AA50C)
                        : Color.fromARGB(255, 196, 197, 197),
                    width: 1.0,
                  ),
                ),
                child: !_checked
                    ? Image.asset(
                        tarefa.icon,
                        width: 30.0,
                        height: 30.0,
                      )
                    : Icon(
                        Icons.done,
                        color: Color(0xFFFFFFFF),
                      ),
              ), // Ícone à esquerda
              Container(
                width: 120.0,
                child: Text(
                  tarefa.nome,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: _checked
                          ? Color(0xFF2AA50C)
                          : Color.fromARGB(255, 59, 69, 245),
                      fontFamily: 'MontSerrat',),
                ),
              ),
              Text(
                DateFormat('HH:mm').format(tarefa.horario),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: _checked
                        ? Color(0xFF2AA50C)
                        : Color.fromARGB(255, 196, 197, 197),
                    fontFamily: 'MontSerrat'),
              ), // Horário à direita
            ],
          ),
        ),
      ),
    );
  }
}
