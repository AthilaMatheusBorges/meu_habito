import 'package:flutter/material.dart';
import 'package:meu_habito/provider/tasks.dart';
import 'package:meu_habito/src/widgets/dash_task.dart';
import 'package:provider/provider.dart';

import '../../models/tarefa_model.dart';
import '../widgets/listcards.dart';
import '../widgets/modal_add_tarefa.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List<Tarefa> tarefas = [
  //   Tarefa(
  //       id: '1',
  //       nome: 'Correr',
  //       horario: '10:00 AM',
  //       icon: 'icons/caminhada.png',
  //       checked: false,
  //       frequencia: [true, false, true, false, true, false, true],
  //       notificacao: false),
  //   Tarefa(
  //       id: '2',
  //       nome: 'Ler',
  //       horario: '02:30 PM',
  //       icon: 'icons/escrita.png',
  //       checked: false,
  //       frequencia: [true, false, true, false, true, false, true],
  //       notificacao: false),
  //   Tarefa(
  //       id: '3',
  //       nome: 'Cozinhar',
  //       horario: '05:00 PM',
  //       icon: 'icons/degustacao-de-vinho.png',
  //       checked: true,
  //       frequencia: [true, false, true, false, true, false, true],
  //       notificacao: false),
  //   Tarefa(
  //       id: '4',
  //       nome: 'Correr',
  //       horario: '10:00 AM',
  //       icon: 'icons/caminhada.png',
  //       checked: true,
  //       frequencia: [true, false, true, false, true, false, true],
  //       notificacao: false),
  //   Tarefa(
  //       id: '5',
  //       nome: 'Ler',
  //       horario: '02:30 PM',
  //       icon: 'icons/escrita.png',
  //       checked: true,
  //       frequencia: [true, false, true, false, true, false, true],
  //       notificacao: false),
  //   Tarefa(
  //       id: '6',
  //       nome: 'Cozinhar',
  //       horario: '05:00 PM',
  //       icon: 'icons/degustacao-de-vinho.png',
  //       checked: false,
  //       frequencia: [true, false, true, false, true, false, true],
  //       notificacao: false),
  // ];

  @override
  Widget build(BuildContext context) {
    final Tarefas tarefas_prov = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Card com Ícone')),
      // ignore: prefer_const_constructors
      body: Center(
        child: Column(children: [
          Dash_task(lista: tarefas_prov.all),
          CardsList(),
          ModalAddTarefa(),
        ]),
      ),
    );
    ;
  }
}
