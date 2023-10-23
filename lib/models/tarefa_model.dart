import 'package:flutter/material.dart';

class Tarefa {
  int id;
  final String nome;
  final String horario;
  final String icon;
  //bool checked;
  final List<bool> frequencia;
  final bool notificacao;

  Tarefa({
    required this.id,
    required this.nome,
    required this.horario,
    required this.icon,
    //required this.checked,
    required this.frequencia,
    required this.notificacao,
  });
}
