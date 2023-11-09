import 'package:flutter/material.dart';
import 'package:meu_habito/models/tarefa_model.dart';
import 'package:meu_habito/repositories/task_repository.dart';
import 'package:meu_habito/src/widgets/card.dart';
import 'package:provider/provider.dart';

class CardsList extends StatefulWidget {
  const CardsList({super.key});

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  bool editCard = false;
  late TaskRepository tarefasRepo;

  @override
  Widget build(BuildContext context) {
    //final Tarefas tasks = Provider.of(context);
    
    tarefasRepo = context.watch<TaskRepository>();
    
    List<Tarefa> tarefas = tarefasRepo.getListaTarefas();

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tarefas do dia',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 59, 69, 245),
                      fontFamily: 'MontSerrat',
                    )),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        editCard = !editCard;
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      color: editCard ? Color(0xFF2AA50C) : Color(0xFF3B45F5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            itemCount: tarefasRepo.count,
            itemBuilder: (BuildContext context, int index) {
              return MyCard(
                // tarefa: tasks.byIndex(index),
                tarefa: tarefas[index],
                edit: editCard,
              );
            },
          ),
        ),
      ],
    );
  }
}
