import 'package:flutter/material.dart';

import '../widgets/button_pupple.dart';
import '../widgets/listcards.dart';
import '../widgets/modal_add_tarefa.dart';
import '../widgets/teste.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              background: const Color.fromARGB(255, 238, 245, 253)),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text('Flutter Card com Ícone')),
          // ignore: prefer_const_constructors
          body: Center(
            child: Column(children: [
              CardsList(),
              ModalAddTarefa(),
              //Container(height: 600.0, child: Teste())
            ]),
          ),
        ));
  }
}
