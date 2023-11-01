import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meu_habito/database/db.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:intl/intl.dart';
import 'package:meu_habito/models/tarefa_model.dart';

class TaskRepository extends ChangeNotifier {
  late Database db;
  List<Tarefa> _tarefas = [];
  List _frequencia = [];

  //get saldo => _saldo;
  List<Tarefa> get tarefas => _tarefas;
  //List<Historico> get historico => _historico;

  TaskRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getTarefas();
    // await _getFrequencia();
  }

  _getTarefas() async {
    _tarefas = [];
    db = await DB.instance.database;
    List tasks = await db.query('tarefas');

    tasks.forEach((tarefa) => _tarefas.add(Tarefa(
          id: tarefa['id'],
          nome: tarefa['nome'],
          horario: tarefa['horario'],
          init: tarefa['init'],
          icon: tarefa['icone'],
          frequencia: _convertBool(tarefa['frequencia']),
          notificacao: _convertNotif(tarefa['notificacao']),
        )));

    print('carregou tarefas');
    print(tasks);
    notifyListeners();
  }

//  _getFrequencia() async {
//   _frequencia = [];
//   db = await DB.instance.database;
//   List tasks = await db.query('frequencia_tarefas');
//  }
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
      'init': task.init,
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

  tarefaFeita(int tarefaId, String data) async {
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

  tasksForDash(String date) async {
    db = await DB.instance.database;
    final List<Map<String, dynamic>> feitas = await db.rawQuery('''
    SELECT * FROM frequencia_tarefas
    WHERE data = ?
  ''', [date]);
    return feitas.length;
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
        init: '2023-10-18 01:21:00.000',
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

  void deletarTask(int taskId) async {
    db = await DB.instance.database;
    await db.rawDelete('''
    DELETE FROM frequencia_tarefas
    WHERE tarefa_id = ?
  ''', [taskId]);
    await db.rawDelete('''
    DELETE FROM tarefas
    WHERE id = ?
  ''', [taskId]);
    notifyListeners();
    _getTarefas();
  }

  getTabelaFreq() async {
    db = await DB.instance.database;
    final List<Map<String, dynamic>> feitas = await db.rawQuery('''
    SELECT * FROM frequencia_tarefas
  ''');
    print(feitas);
  }

  getPercentGeral() async {
    //pega as tarefas feitas no dia no db
    db = await DB.instance.database;
    final List<Map<String, dynamic>> frequencia = await db.rawQuery('''
      SELECT * FROM frequencia_tarefas
      ''');

    final List<Map<String, dynamic>> datas = await db.rawQuery(
      '''SELECT DISTINCT data FROM frequencia_tarefas''',
    );

    print(frequencia);
    print(datas);

    Map<String, double> saida = {};

    for (int i = 0; i < datas.length; i++) {
      String data = datas[i]['data'];
      //convertendo a data string em um datetime
      DateTime dia = DateTime.parse("${data} 23:59:00.000");

      double percent = 0.0;
      //tarefas cadastradas antes do dia analisado
      int tarefasValidas = 0;
      //das tarefas cadastradas quantas foram feitas no dia
      int tarefasFeitas = 0;

      _tarefas.forEach((element) {
        //data de criação da tarefa
        DateTime diaCriacaoTarefa = DateTime.parse(element.init);

        //verifica se a tarefa foi criada antes do dia analisado e se ela está programada para ser feita nesse dia da semana
        if (diaCriacaoTarefa.isBefore(dia) &&
            element.frequencia[dia.weekday - 1]) tarefasValidas++;

        List<Map<String, dynamic>> mapsComDataDesejada = frequencia
            .where((map) =>
                (map["data"] == data && map['tarefa_id'] == element.id))
            .toList();

        if (mapsComDataDesejada.length > 0) tarefasFeitas++;
      });

      //Realiza o calculo do percentual das tarefas feitas no dia

      if (tarefasValidas == 0 || (tarefasFeitas == 0 && tarefasValidas > 0))
        percent = 0.0;
      else if (tarefasFeitas > 0 && tarefasFeitas < tarefasValidas)
        percent = tarefasFeitas / tarefasValidas;
      else if (tarefasFeitas >= tarefasValidas) percent = 1.0;

      saida.putIfAbsent(data, () => percent);
    }
    
    return saida;
  }

  getDatePrimeiraTask(){
    DateTime antiga = DateTime.now();

    _tarefas.forEach((element) {
      DateTime data = DateTime.parse(element.init);
      if(data.isBefore(antiga)) antiga = data;
    });

    return antiga;
  }
  
  mockarDB() {
    DateTime dataAtual = DateTime.now();
    final random = Random();
    // Subtrai um Duration de um dia da data atual
    _tarefas.forEach((element) {
      for (int i = 0; i < 10; i++) {
        DateTime dataXDiasAntes = dataAtual.add(Duration(days: i));
        String dataFormatada = DateFormat('yyyy-MM-dd').format(dataXDiasAntes);

        if(random.nextBool()) tarefaFeita(element.id, dataFormatada);
      }
    });
    notifyListeners();
  }
}
