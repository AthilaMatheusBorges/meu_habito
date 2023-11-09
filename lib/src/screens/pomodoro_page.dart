import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meu_habito/repositories/task_repository.dart';
import 'package:provider/provider.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  DateTime tempo = DateTime(2023, 1, 1, 0, 25);
  bool init = false;
  late Timer _timer;
  late TaskRepository repo;
  int pomo = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration.zero, () { });
    // Crie um timer que executa a cada segund
  }

  @override
  void dispose() {
    // Certifique-se de cancelar o timer quando o widget for descartado.
    _timer.cancel();
    super.dispose();
  }

  void inicia() {
    if (!init)
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          tempo = tempo.subtract(Duration(seconds: 1));
        });
      });
  }

  setPomo() async{
    await repo.setPomodoro();
  }

  @override
  Widget build(BuildContext context) {
    repo = context.watch<TaskRepository>();

    if (DateFormat('mm:ss').format(tempo) == "00:00") {
      _timer.cancel();
      tempo = DateTime(2023, 1, 1, 0, 25);
      setPomo();
      init = false;
    }

    (() async{
    int result = await repo.getPomodoro();
    setState(() {
      if(pomo != result)
        pomo = result;
    });
  })();
    
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.only(left:30.0, top: 50.0),
            child: Container(
              child: Row(
                children: [
                  Container(
                width: 50.0,
                height: 50.0,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromARGB(255, 196, 197, 197),
                    width: 1.0,
                  ),
                ),
                child: IconButton(
                  onPressed: () {Navigator.of(context).pop();},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xFF3B45F5),
                  ),
                ),
              ),],
              ),
            ),
          )),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Método Pomodoro",
                  style: TextStyle(
                      color: Color(0xFF6C73F5),
                      fontFamily: 'MontSerrat',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset('assets/icons/tomate.png', width: 35.0, height: 35.0,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: const Text(
              "É um método de gerenciamento de tempo que envolve trabalhar intensamente em uma tarefa por 25 minutos seguidos por uma pausa de 5 minutos. Isso auxilia na produtividade e na concentração.",
              style: TextStyle(
                  color: Color.fromARGB(255, 196, 197, 197),
                  fontFamily: 'MontSerrat',
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal),
                  softWrap: true,
                  textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:50.0),
            child: Text(
              "${DateFormat('mm:ss').format(tempo)}",
              style: TextStyle(
                  color: Color(0xFF6C73F5),
                  fontFamily: 'MontSerrat',
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {
                inicia();
                init = true;
              },
              icon: Icon(Icons.timer),
              label: Text('Começar')),
              Padding(padding: EdgeInsets.only(top: 150.0)),
              Text("Períodos produtivos: ${pomo}", style: TextStyle(
                      color: Color(0xFF6C73F5),
                      fontFamily: 'MontSerrat',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold))
        ],

      )),
    );
  }
}
