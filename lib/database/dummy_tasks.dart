import '../models/tarefa_model.dart';

const DUMMY_TASKS = {
  '1': const Tarefa(
    nome: 'Correr',
    horario: '10:00 AM',
    icon: 'icons/caminhada.png',
    checked: false,
    frequencia: [true, false, true, false, true, false, true],
    notificacao: false),
  '2': const Tarefa(
    nome: 'Ler',
    horario: '02:30 PM',
    icon: 'icons/escrita.png',
    checked: false,
    frequencia: [true, false, true, false, true, false, true],
    notificacao: false),
  '3': const Tarefa(
    nome: 'Cozinhar',
    horario: '05:00 PM',
    icon: 'icons/degustacao-de-vinho.png',
    checked: true,
    frequencia: [true, false, true, false, true, false, true],
    notificacao: false),
  '4': const Tarefa(
    nome: 'Correr',
    horario: '10:00 AM',
    icon: 'icons/caminhada.png',
    checked: true,
    frequencia: [true, false, true, false, true, false, true],
    notificacao: false),
  '5': const Tarefa(
    nome: 'Ler',
    horario: '02:30 PM',
    icon: 'icons/escrita.png',
    checked: true,
    frequencia: [true, false, true, false, true, false, true],
    notificacao: false),
};
