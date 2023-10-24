import 'dart:math';

import '../models/tarefa_model.dart';
DateTime hora = DateTime(2023, 9, 27, 14, 30);
Map DUMMY_TASKS = {
  '1': Tarefa(
    id: '1',
    nome: 'Correr',
    horario: DateTime.now(),
    icon: 'icons/caminhada.png',
    checked: false,
    frequencia: [true, false, true, false, true, false, true],
    notificacao: false),
  '2': Tarefa(
    id: '2',
    nome: 'Ler',
    horario: hora,
    icon: 'icons/escrita.png',
    checked: false,
    frequencia: [true, false, true, false, true, false, true],
    notificacao: false),
  '3': Tarefa(
    id: '3',
    nome: 'Cozinhar',
    horario: hora,
    icon: 'icons/degustacao-de-vinho.png',
    checked: true,
    frequencia: [true, false, true, false, true, false, true],
    notificacao: false),
  '4': Tarefa(
    id: '4',
    nome: 'Correr',
    horario: hora,
    icon: 'icons/caminhada.png',
    checked: true,
    frequencia: [true, false, true, false, true, false, true],
    notificacao: false),
  '5': Tarefa(
    id: '5',
    nome: 'Ler',
    horario: hora,
    icon: 'icons/escrita.png',
    checked: true,
    frequencia: [true, false, true, false, true, false, true],
    notificacao: false),
};
