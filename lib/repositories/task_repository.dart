import 'package:flutter/material.dart';
import 'package:meu_habito/database/db.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:meu_habito/models/tarefa_model.dart';

class TaskRepository extends ChangeNotifier {
  late Database db;
  List<Tarefa> _tarefas = [];

  //get saldo => _saldo;
  List<Tarefa> get tarefas => _tarefas;
  //List<Historico> get historico => _historico;

  TaskRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getTarefas();
  }

  _getTarefas() async {
    _tarefas = [];
    db = await DB.instance.database;
    List tasks = await db.query('tarefas');
    print(tasks);

    tasks.forEach((tarefa) => _tarefas.add(Tarefa(
            id: tarefa['id'],
            nome: tarefa['nome'],
            horario: tarefa['horario'],
            icon: tarefa['icone'],
            frequencia: _convertBool(tarefa['frequencia']),
            notificacao: _convertNotif(tarefa['notificacao']),
          ))
        );

    print('carregou tarefas');
    //print(tasks);
    notifyListeners();
  }

  _convertNotif(int i) {
    if (i == 1)
      return true;
    else
      return false;
  }

  _convertBool(String bits) {
    List<bool> saida = [];
    for (int i = 0; i < bits.length; i++) {
      if (bits[i] == '1')
        saida.add(true);
      else
        saida.add(false);
    }
    return saida;
  }

  _convertBit(List<bool> list) {
    String saida = '';
    list.forEach((element) {
      if (element == true)
        saida += '1';
      else
        saida += '0';
    });
    return saida;
  }

  limparDatabase() async {
    db = await DB.instance.database;
    db.delete('tarefas');
  }

  addTarefa(Tarefa task) async {
    db = await DB.instance.database;
    db.insert('tarefas', {
      'nome': task.nome,
      'horario': task.horario,
      'icone': task.icon,
      'notificacao': task.notificacao,
      'frequencia': _convertBit(task.frequencia),
    });

    //print(await db.query('tarefas'));
    _getTarefas();
    notifyListeners();
  }

  atualizaTarefa(Tarefa tarefa) async {
    db = await DB.instance.database;
    int id = tarefa.id;
    db.update(
        'tarefas',
        {
          'nome': tarefa.nome,
          'horario': tarefa.horario,
          'icone': tarefa.icon,
          'notificacao': tarefa.notificacao,
          'frequencia': _convertBit(tarefa.frequencia),
        },
        where: 'id = ?',
        whereArgs: [id]);
    _getTarefas();
    notifyListeners();
  }

tarefaFeita(int tarefaId, String data) async{
  db = await DB.instance.database;
  db.insert('frequencia_tarefas', {
  'tarefa_id': tarefaId, // ID da tarefa associada
  'data': data, 
  //'2023-10-20', // Data em que a tarefa foi realizada
});

    notifyListeners();
}

deleteTaskFromFrequency(int taskId, String date) async {
  db = await DB.instance.database;
  await db.rawDelete('''
    DELETE FROM frequencia_tarefas
    WHERE tarefa_id = ? AND data = ?
  ''', [taskId, date]);
  
  notifyListeners();
}

isTaskInFrequency(int taskId, String date) async {
  db = await DB.instance.database;
  final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT * FROM frequencia_tarefas
    WHERE tarefa_id = ? AND data = ?
  ''', [taskId, date]);
  return result.isNotEmpty;
  
}

tasksForDash(String date)async {
  db = await DB.instance.database;
  final List<Map<String, dynamic>> feitas = await db.rawQuery('''
    SELECT * FROM frequencia_tarefas
    WHERE data = ?
  ''', [date]);
  
  final List<Map<String, dynamic>> total = await db.rawQuery('''
    SELECT * FROM tarefas
  ''');
  
  return [total.length - (total.length - feitas.length), total.length];
}


  getListaTarefas() {
    return _tarefas;
  }

  //Implementar pegando a task direto do SQFLITE
  byIndex(int i) {
    Tarefa saida = Tarefa(
        id: 50,
        nome: 'teste',
        horario: '2023-10-18 01:21:00.000',
        icon: 'assets/icons/escrita.png',
        frequencia: [
          true,
          true,
          true,
          true,
          true,
          true,
          true,
        ],
        notificacao: true);
    _tarefas.forEach((element) {
      if (element.id == i) {
        saida = element;
      }
    });
    return saida;
  }

  int get count {
    return _tarefas.length;
  }
}

