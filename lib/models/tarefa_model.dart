import 'package:flutter/material.dart';

class Tarefa {
  final String id;
  final String nome;
  final DateTime horario;
  final String icon;
  bool checked;
  final List<bool> frequencia;
  final bool notificacao;

  Tarefa({
    this.id = '',
    required this.nome,
    required this.horario,
    required this.icon,
    required this.checked,
    required this.frequencia,
    required this.notificacao,
  });
}
