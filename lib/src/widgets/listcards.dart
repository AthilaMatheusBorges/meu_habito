import 'package:flutter/material.dart';
import 'package:meu_habito/src/widgets/card.dart';

import '../../models/tarefa_model.dart';

class CardsList extends StatefulWidget {
  const CardsList({super.key});
  //final List<Tarefa> lista_tarefas;

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {

  final List<Tarefa> tarefas = [
    Tarefa(
        nome: 'Correr',
        horario: '10:00 AM',
        icon: 'icons/caminhada.png',
        checked: false),
    Tarefa(
        nome: 'Ler',
        horario: '02:30 PM',
        icon: 'icons/escrita.png',
        checked: true),
    Tarefa(
        nome: 'Cozinhar',
        horario: '05:00 PM',
        icon: 'icons/degustacao-de-vinho.png',
        checked: true),
    Tarefa(
        nome: 'Correr',
        horario: '10:00 AM',
        icon: 'icons/caminhada.png',
        checked: true),
    Tarefa(
        nome: 'Ler',
        horario: '02:30 PM',
        icon: 'icons/escrita.png',
        checked: true),
    Tarefa(
        nome: 'Cozinhar',
        horario: '05:00 PM',
        icon: 'icons/degustacao-de-vinho.png',
        checked: false),
  ];

    void setCheckbox(int index) {
    setState(() {
      tarefas[index].checked = !tarefas[index].checked;
      print(tarefas[index].checked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (BuildContext context, int index) {
          return MyCard(
            nome: tarefas[index].nome,
            horario: tarefas[index].horario,
            icon: tarefas[index].icon,
            checked: tarefas[index].checked,
            index: index,
            setCard: setCheckbox
          );
        },
      ),
    );
  }
}