// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:meu_habito/database/dummy_tasks.dart';

// import '../models/tarefa_model.dart';

// class Tarefas with ChangeNotifier {
//   Map<String, Tarefa> _items = {...DUMMY_TASKS};

//   List<Tarefa> get all {
//     return [..._items.values];
//   }

//   int get count {
//     return _items.length;
//   }

//   Tarefa byId(String id){
//     Tarefa task = _items[id]!;
//     return task;
//   }

//   Tarefa byIndex(int i) {
//     return _items.values.elementAt(i);
//   }

//  void checkedTask(String taskId){
//   // Verifique se a chave taskId existe no mapa _items
//   if (_items.containsKey(taskId)) {
//     Tarefa task = _items[taskId]!; // Obtenha a tarefa correspondente ao taskId
//     task.checked = !task.checked;
//     _items.update(taskId, (value) => task);
//     notifyListeners();
//   } else {
//     print("Chave não encontrada no mapa _items.");
//   }
// }



//   void put(Tarefa task) {
//     if (task == null) {
//       return;
//     }

//     if (task.id != null &&
//         task.id.trim().isNotEmpty &&
//         _items.containsKey(task.id)) {
//       _items.update(task.id, (value) => task);
//     }else{

//     final id = Random().nextDouble().toString();

//     _items.putIfAbsent(
//       id,
//       () => Tarefa(
//         id: id,
//         nome: task.nome,
//         horario: task.horario,
//         icon: task.icon,
//         checked: task.checked,
//         frequencia: task.frequencia,
//         notificacao: task.notificacao,
//       ),
//     );
//     }

//     //print(id);
//     notifyListeners();
//   }
// }
