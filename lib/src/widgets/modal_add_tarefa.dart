import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:meu_habito/src/widgets/button_pupple.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

/// Flutter code sample for [showModalBottomSheet].
///
class ModalAddTarefa extends StatefulWidget {
  const ModalAddTarefa({super.key});

  @override
  State<ModalAddTarefa> createState() => _ModalAddTarefaState();
}

class _ModalAddTarefaState extends State<ModalAddTarefa> {
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonPurpple(
        name: 'Nova Tarefa',
        action: () {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Dialog(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Form(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Adicione uma nova tarefa'),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) =>
                                                      Colors.transparent)),
                                      child: const Text('X'),
                                      onPressed: () =>
                                          Navigator.pop(dialogContext),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Nome',
                                  ),
                                ),
                                DateTimeField(
                                  format: format,
                                  onShowPicker: (context, currentValue) async {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()),
                                    );
                                    return DateTimeField.convert(time);
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Horário',
                                  ),
                                ),
                                Text('Frequência:'),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      CheckboxDia(
                                          dia: 0, setCheckbox: setCheckbox),
                                      CheckboxDia(
                                          dia: 1, setCheckbox: setCheckbox),
                                      CheckboxDia(
                                          dia: 2, setCheckbox: setCheckbox),
                                      CheckboxDia(
                                          dia: 3, setCheckbox: setCheckbox),
                                      CheckboxDia(
                                          dia: 4, setCheckbox: setCheckbox),
                                      CheckboxDia(
                                          dia: 5, setCheckbox: setCheckbox),
                                      CheckboxDia(
                                          dia: 6, setCheckbox: setCheckbox),
                                    ]),
                                CheckboxListTile(
                                  title: Text('Ativar notificação.'),
                                  value: checkNotif,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      checkNotif = value!;
                                    });
                                    print(context);
                                    //atualizaNotif();
                                  },
                                ),
                                Text(checkNotif ? 'True' : 'False'),
                                ButtonPurpple(
                                    name: 'Adicionar', action: () => {})
                              ]),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class CheckboxDia extends StatefulWidget {
  const CheckboxDia({
    super.key,
    required this.dia,
    required this.setCheckbox,
  });

  final dia;
  final setCheckbox;

  @override
  State<CheckboxDia> createState() => _CheckboxDiaState();
}

class _CheckboxDiaState extends State<CheckboxDia> {
  bool checkValue = true;
  List<String> dias = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.amber),
      child: Column(
        children: [
          Text(dias[widget.dia]),
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
    );
  }
}
