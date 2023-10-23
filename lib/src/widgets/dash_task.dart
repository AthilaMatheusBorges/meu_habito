//import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/tarefa_model.dart';
import '../../repositories/task_repository.dart';

class Dash_task extends StatefulWidget {
  const Dash_task({super.key});

  @override
  State<Dash_task> createState() => _Dash_taskState();
}

class _Dash_taskState extends State<Dash_task> {
  late TaskRepository tarefas;
  List<int> dados = [5,10];

  @override
  Widget build(BuildContext context) {
    
    tarefas = context.watch<TaskRepository>();
    DateTime agora = DateTime.now();
    String dataFormatada = DateFormat('yyyy-MM-dd').format(agora);
    
  (() async {
    List <int> saida = await tarefas.tasksForDash(dataFormatada);
    setState(() {
      dados = saida;
    });
    })();

    double percentual = (dados[0] / dados[1]) * 100;

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 150.0,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF6C73F5),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CircularPercentIndicator(
                    backgroundColor: Colors.transparent,
                    animation: true,
                    animationDuration: 800,
                    radius: 35.0,
                    lineWidth: 6.0,
                    percent: percentual / 100,
                    center: Text(
                      '${percentual.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontFamily: 'MontSerrat',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    progressColor: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suas tarefas estão \nquase acabando!',
                    style: TextStyle(
                      fontFamily: 'MontSerrat',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: Text(
                      "${dados[0]} de ${dados[1]} completas.",
                      style: TextStyle(
                        fontFamily: 'MontSerrat',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w100,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressIndicatorExample extends StatefulWidget {
  const ProgressIndicatorExample({super.key});

  @override
  State<ProgressIndicatorExample> createState() =>
      _ProgressIndicatorExampleState();
}

class _ProgressIndicatorExampleState extends State<ProgressIndicatorExample>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Circular progress indicator',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            CircularProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Circular progress indicator',
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'determinate Mode',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Switch(
                  value: determinate,
                  onChanged: (bool value) {
                    setState(() {
                      determinate = value;
                      if (determinate) {
                        controller.stop();
                      } else {
                        controller
                          ..forward(from: controller.value)
                          ..repeat();
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
