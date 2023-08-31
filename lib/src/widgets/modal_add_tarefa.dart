import 'package:flutter/material.dart';
import 'package:meu_habito/src/widgets/button_pupple.dart';

/// Flutter code sample for [showModalBottomSheet].
/// 
class ModalAddTarefa extends StatefulWidget {
  const ModalAddTarefa({super.key});

  @override
  State<ModalAddTarefa> createState() => _ModalAddTarefaState();
}

class _ModalAddTarefaState extends State<ModalAddTarefa> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonPurpple(
        name:'Nova Tarefa',
        action: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );;
  }
}
