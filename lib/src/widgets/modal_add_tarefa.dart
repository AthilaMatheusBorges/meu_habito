import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:date_field/date_field.dart';

import 'package:intl/intl.dart';
import 'package:meu_habito/models/tarefa_model.dart';
import 'package:meu_habito/src/widgets/button_pupple.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:meu_habito/src/widgets/icon_selector.dart';
import 'package:provider/provider.dart';

import '../../provider/tasks.dart';

/// Flutter code sample for [showModalBottomSheet].
///
class ModalAddTarefa extends StatefulWidget {
  const ModalAddTarefa({super.key});

  @override
  State<ModalAddTarefa> createState() => _ModalAddTarefaState();
}

class _ModalAddTarefaState extends State<ModalAddTarefa> {
  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  final List<String> icons = [
    'icons/caminhada.png',
    'icons/croche.png',
    'icons/de-costura.png',
    'icons/degustacao-de-vinho.png',
    'icons/desenhando.png',
    'icons/escrita.png',
    'icons/ginastica.png',
    'icons/observacao-de-passaros.png',
    'icons/pintura.png',
    'icons/reparo-do-carro.png',
    //'icons/caminhada.png',
    // Adicione mais caminhos para os seus ícones aqui
  ];

  String selectedIcon = 'icons/escrita.png';

   atualizaIcon (String novo){
    setState(() {
      selectedIcon = novo;
    });
   }

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
      //print(dias);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Tarefas tasks = Provider.of(context);

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
                      //width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.7,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Adicione uma nova tarefa',
                                      style: TextStyle(
                                          fontFamily: 'MontSerrat',
                                          fontSize: 14,
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
                                IconSelector(atualiza: atualizaIcon,),
                                Container(
                                  height: 64,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color:
                                        Color(0xFFE4E5FE), // Cor de fundo roxo
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Color(0xFF3B45F5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                            fontFamily: 'MontSerrat',
                                            color: Color(0xFF6C73F5),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          labelText: 'Nome',
                                        ),
                                        onSaved: (value) =>
                                            _formData['nome'] = value,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 64,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color:
                                        Color(0xFFE4E5FE), // Cor de fundo roxo
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: DateTimeFormField(
                                        dateTextStyle: TextStyle(
                                          color: Color(0xFF3B45F5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                            height: 0.3,
                                            color: Color(0xFF6C73F5),
                                            fontFamily: 'MontSerrat',
                                            fontWeight: FontWeight.w600,
                                          ),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          border: InputBorder.none,
                                          suffixIcon: Icon(
                                            Icons.timer,
                                            color: Color(0xFF6C73F5),
                                          ),
                                          labelText: 'Horário',
                                        ),
                                        mode: DateTimeFieldPickerMode.time,
                                        autovalidateMode:
                                            AutovalidateMode.always,
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
                                  contentPadding: EdgeInsets.only(left: 40, right: 40),
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
                                ButtonPurpple(
                                    name: 'Adicionar',
                                    action: () => {
                                          _form.currentState?.save(),
                                          tasks.put(
                                            Tarefa(
                                                nome: _formData['nome'],
                                                horario: _formData['horario'],
                                                icon: selectedIcon,
                                                checked: false,
                                                frequencia: dias,
                                                notificacao: checkNotif),
                                          ),
                                          Navigator.of(context).pop(),
                                        })
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
      decoration: BoxDecoration(color: Color(0xFFE4E5FE)),
      child: Column(
        children: [
          Text(
            dias[widget.dia],
            style: TextStyle(
                fontFamily: 'MontSerrat',
                fontSize: 14,
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
    );
  }
}
