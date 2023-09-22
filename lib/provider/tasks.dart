import 'dart:math';
import 'package:flutter/material.dart';
import 'package:meu_habito/database/dummy_tasks.dart';

import '../models/tarefa_model.dart';

class Tarefas with ChangeNotifier {
  Map<String, Tarefa> _items = {...DUMMY_TASKS};

  List<Tarefa> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Tarefa byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Tarefa task) {
    if (task == null) {
      return;
    }

    if (task.id != null &&
        task.id.trim().isNotEmpty &&
        _items.containsKey(task.id)) {
      _items.update(task.id, (value) => task);
    }

    final id = Random().nextDouble().toString();

    _items.putIfAbsent(
      id,
      () => Tarefa(
        nome: 'Ler',
        horario: '02:30 PM',
        icon: 'icons/escrita.png',
        checked: false,
        frequencia: [true, false, true, false, true, false, true],
        notificacao: false,
      ),
    );
    notifyListeners();
  }
}
