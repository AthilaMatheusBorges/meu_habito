import 'package:flutter/material.dart';
import 'package:meu_habito/provider/tasks.dart';
import 'package:meu_habito/src/widgets/card.dart';
import 'package:provider/provider.dart';

class CardsList extends StatefulWidget {
  const CardsList({super.key});

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  @override
  Widget build(BuildContext context) {
    final Tarefas tasks = Provider.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        itemCount: tasks.count,
        itemBuilder: (BuildContext context, int index) {
          return MyCard(
            tarefa: tasks.byIndex(index),
          );
        },
      ),
    );
  }
}
