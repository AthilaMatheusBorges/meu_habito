import 'package:flutter/material.dart';

import '../widgets/button_pupple.dart';
import '../widgets/listcards.dart';
import '../widgets/modal_add_tarefa.dart';
import '../widgets/rascunho.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: const Text('Flutter Card com Ícone')),
          // ignore: prefer_const_constructors
          body: Center(
            child: Column(children: [
              CardsList(),
              ModalAddTarefa(),
              //Container(height: 600.0, child: Teste())
            ]),
          ),
        );
  }
}
