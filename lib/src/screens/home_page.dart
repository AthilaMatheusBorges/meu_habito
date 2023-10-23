import 'package:flutter/material.dart';
import 'package:meu_habito/provider/tasks.dart';
import 'package:meu_habito/src/widgets/button_pupple.dart';
import 'package:meu_habito/src/widgets/dash_task.dart';
import 'package:meu_habito/src/widgets/top_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    //final Tarefas tarefas_prov = Provider.of(context);
    return Scaffold(
      // ignore: prefer_const_constructors
      body: Center(
        child: Column(children: [
          TopBar(),
          Dash_task(),
          CardsList(),
          ButtonPurpple(
              name: 'Nova Tarefa',
              action: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) => ModalAddTarefa(taskId: 1000,),
                );
              }),
        ]),
      ),
    );
    ;
  }
}
