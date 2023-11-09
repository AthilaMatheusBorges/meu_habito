
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:meu_habito/models/tarefa_model.dart';
import 'package:meu_habito/repositories/task_repository.dart';
import 'package:meu_habito/src/widgets/button_pupple.dart';
import 'package:meu_habito/src/widgets/icon_selector.dart';
import 'package:provider/provider.dart';


/// Flutter code sample for [showModalBottomSheet].
///
class ModalAddTarefa extends StatefulWidget {
  ModalAddTarefa({super.key, required this.taskId});
  int taskId;
  @override
  State<ModalAddTarefa> createState() => _ModalAddTarefaState();
}

class _ModalAddTarefaState extends State<ModalAddTarefa> {
  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  late TaskRepository tarefas;

  final List<String> icons = [
    'assets/icons/caminhada.png',
    'assets/icons/croche.png',
    'assets/icons/de-costura.png',
    'assets/icons/degustacao-de-vinho.png',
    'assets/icons/desenhando.png',
    'assets/icons/escrita.png',
    'assets/icons/ginastica.png',
    'assets/icons/observacao-de-passaros.png',
    'assets/icons/pintura.png',
    'assets/icons/reparo-do-carro.png',
  ];

  //cada bool representa um dia da semana começando pelo domingo
  List<bool> dias = [true, true, true, true, true, true, true];

  final format = DateFormat('HH:mm');
  bool checkNotif = true;

  atualizaNotif() {
    setState(() => checkNotif = !checkNotif);
  }

  void setCheckbox(int dia) {
    setState(() {
      dias[dia] = !dias[dia];
      print(dias);
    });
  }

  String selectedIcon = 'assets/icons/escrita.png';

  void _loadFormData(Tarefa task) {
    _formData['id'] = task.id;
    _formData['nome'] = task.nome;
    _formData['horario'] = task.horario;
    _formData['init'] = task.init;
    selectedIcon = task.icon;
    _formData['frequencia'] = task.frequencia;
    setState(() {
      dias = _formData['frequencia'];
      this.checkNotif = task.notificacao;
    });
  }

  atualizaIcon(String novo) {
    setState(() {
      selectedIcon = novo;
      //_formData['icon'] = novo;
      print(selectedIcon);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final Tarefas tasks = Provider.of(context);
    tarefas = context.watch<TaskRepository>();
    //tarefas.limparDatabase();
    print(tarefas.getListaTarefas());

    if (widget.taskId != 1000) {
      _loadFormData(tarefas.byIndex(widget.taskId));
    }

    return SingleChildScrollView(
      child: Center(child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            child: Container(
              //width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.85,
              color: Color.fromARGB(255, 238, 245, 253),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _form,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.taskId == 1000
                                  ? 'Adicione uma nova tarefa'
                                  : 'Editar tarefa',
                              style: TextStyle(
                                  fontFamily: 'MontSerrat',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3B45F5)),
                            ),
                            IconButton(
                                padding: EdgeInsets.all(0),
                                color: Color(0xFFE87474),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close)),
                          ],
                        ),
                        IconSelector(
                          atualiza: atualizaIcon,
                          selected: this.selectedIcon,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFFE4E5FE), // Cor de fundo roxo
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Wrap(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.length < 3 ||
                                          value == null ||
                                          value.isEmpty) {
                                        return 'No mínimo 3 caracteres.';
                                      }
                                      return null;
                                    },
                                    initialValue: widget.taskId == 1000
                                        ? ''
                                        : _formData['nome'],
                                    style: TextStyle(
                                      color: Color(0xFF3B45F5),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                        fontFamily: 'MontSerrat',
                                        color: Color(0xFF6C73F5),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                      labelText: 'Nome',
                                    ),
                                    onSaved: (value) =>
                                        _formData['nome'] = value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 15.0)),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFFE4E5FE), // Cor de fundo roxo
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: DateTimeFormField(
                                initialValue: widget.taskId == 1000
                                    ? DateTime.now()
                                    : DateFormat("yyyy-MM-dd HH:mm")
                                        .parse(_formData['horario']),
                                dateTextStyle: TextStyle(
                                  color: Color(0xFF3B45F5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    //height: 0.3,
                                    color: Color(0xFF6C73F5),
                                    fontFamily: 'MontSerrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.timer,
                                    color: Color(0xFF6C73F5),
                                  ),
                                  labelText: 'Horário',
                                ),
                                mode: DateTimeFieldPickerMode.time,
                                autovalidateMode: AutovalidateMode.always,
                                validator: (e) => (e?.day ?? 0) == 1
                                    ? 'Please not the first day'
                                    : null,
                                onDateSelected: (DateTime value) {
                                  print(value);
                                },
                                onSaved: (value) =>
                                    _formData['horario'] = value,
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          'Frequência:',
                          style: TextStyle(
                              fontFamily: 'MontSerrat',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3B45F5)),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CheckboxDia(
                                  dia: 0,
                                  setCheckbox: setCheckbox,
                                  initialValue: dias[0]),
                              CheckboxDia(
                                  dia: 1,
                                  setCheckbox: setCheckbox,
                                  initialValue: dias[1]),
                              CheckboxDia(
                                  dia: 2,
                                  setCheckbox: setCheckbox,
                                  initialValue: dias[2]),
                              CheckboxDia(
                                  dia: 3,
                                  setCheckbox: setCheckbox,
                                  initialValue: dias[3]),
                              CheckboxDia(
                                  dia: 4,
                                  setCheckbox: setCheckbox,
                                  initialValue: dias[4]),
                              CheckboxDia(
                                  dia: 5,
                                  setCheckbox: setCheckbox,
                                  initialValue: dias[5]),
                              CheckboxDia(
                                  dia: 6,
                                  setCheckbox: setCheckbox,
                                  initialValue: dias[6]),
                            ]),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.only(left: 10, right: 10),
                          title: const Text(
                            'Ativar notificação:',
                            style: TextStyle(
                                fontFamily: 'MontSerrat',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3B45F5)),
                          ),
                          value: checkNotif,
                          onChanged: (bool? value) {
                            setState(() {
                              checkNotif = value!;
                            });
                            print(context);
                            //atualizaNotif();
                          },
                        ),
                        //Text(checkNotif ? 'True' : 'False'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.taskId != 1000)
                              IconButton(
                                  onPressed: () {
                                    deletarTask(context);
                                  },
                                  icon: Container(
                                    width: 45,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 196, 197, 197),
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Icon(Icons.delete),
                                  )),
                            ButtonPurpple(
                                name: widget.taskId == 1000
                                    ? 'Adicionar'
                                    : 'Atualizar',
                                action: () => {
                                      _form.currentState?.save(),
                                      //tarefas.limparDatabase(),
                                      print(_formData['horario']),
                                      if (_form.currentState!.validate())
                                        {
                                          if (widget.taskId == 1000)
                                            {
                                              tarefas.addTarefa(
                                                Tarefa(
                                                  id: 1000,
                                                  nome: _formData['nome'],
                                                  horario: _formData['horario']
                                                      .toString(),
                                                      init: _formData['horario']
                                                      .toString(),
                                                  icon: selectedIcon,
                                                  frequencia: dias,
                                                  notificacao: checkNotif,
                                                ),
                                              ),
                                            }
                                          else
                                            {
                                              tarefas.atualizaTarefa(
                                                Tarefa(
                                                  id: widget.taskId,
                                                  nome: _formData['nome'],
                                                  horario: _formData['horario']
                                                      .toString(),
                                                  init: _formData['init']
                                                      .toString(),
                                                  icon: selectedIcon,
                                                  //checked: false,
                                                  frequencia: dias,
                                                  notificacao: checkNotif,
                                                ),
                                              ),
                                            },
                                          Navigator.of(context).pop(),
                                        },
                                    }),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          );
        },
      )),
    );
  }

  void deletarTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tem certeza que deseja excluir a tarefa?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Não'),
            ),
            TextButton(
                onPressed: () {
                  tarefas.deletarTask(widget.taskId);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('Sim')),
          ],
        );
      },
    );
  }
}

class CheckboxDia extends StatefulWidget {
  const CheckboxDia({
    super.key,
    required this.dia,
    required this.setCheckbox,
    required this.initialValue,
  });

  final dia;
  final setCheckbox;
  final bool initialValue;

  @override
  State<CheckboxDia> createState() => _CheckboxDiaState();
}

class _CheckboxDiaState extends State<CheckboxDia> {
  List<String> diasLetra = ['S', 'T', 'Q', 'Q', 'S', 'S','D'];
  @override
  Widget build(BuildContext context) {
    bool checkValue = widget.initialValue;

    return Container(
      decoration: BoxDecoration(color: Color(0xFFE4E5FE)),
      child: SizedBox(
        width: 30,
        height: 65,
        child: Column(
          children: [
            Text(
              diasLetra[widget.dia],
              style: TextStyle(
                  fontFamily: 'MontSerrat',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B45F5)),
            ),
            Checkbox(
              checkColor: Colors.white,
              //fillColor: MaterialStateProperty.resolveWith(getColor),
              value: checkValue,
              onChanged: (bool? value) {
                setState(() {
                  checkValue = value!;
                });
                widget.setCheckbox(widget.dia);
              },
            )
          ],
        ),
      ),
    );
  }
}
