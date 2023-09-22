import 'package:flutter/material.dart';

class Tarefa {
  final String id;
  final String nome;
  final String horario;
  final String icon;
  final bool checked;
  final List<bool> frequencia;
  final bool notificacao;

  const Tarefa({
    this.id = '',
    required this.nome,
    required this.horario,
    required this.icon,
    required this.checked,
    required this.frequencia,
    required this.notificacao,
  });
}
