import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import '../../repositories/task_repository.dart';

bool load = false;
Map<String, double> percentuais = {};
DateTime _focusedDay = DateTime.now();
DateTime tarefaMaisAntiga = DateTime.now();

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late TaskRepository tarefas;

  @override
  void initState() {
    super.initState();
    load = false;
  }

  Future carregaPercentuais(DateTime dia) async {
    // Map<String, double> result = await tarefas.getPercent(dia);
    Map<String, double> resultPercent = await tarefas.getPercentGeral();
    DateTime resultTarefaAntiga = await tarefas.getDatePrimeiraTask();

    setState(() {
      percentuais = resultPercent;
      tarefaMaisAntiga = resultTarefaAntiga;
      load = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    tarefas = context.watch<TaskRepository>();

    if (load == false) carregaPercentuais(_focusedDay);

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
      body: Column(
        children: <Widget>[
          if (load == false)
            Column(
              children: [
                const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF3B45F5),
                  ),
                ),
              ],
            )
          else
            TableCalendar(
              locale: 'pt_BR',
              firstDay: DateTime.utc(DateTime.now().year, 1, 1),
              lastDay: DateTime.utc(DateTime.now().year, 12, 30),
              // onPageChanged: (focusedDay) {
              //   setState(() {
              //     _focusedDay = focusedDay;
              //     //load = false;
              //   });
              //   //carregaPercentuais(_focusedDay);
              // },
              focusedDay: _focusedDay,
              headerStyle: const HeaderStyle(
                headerPadding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF3B45F5),
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF3B45F5),
                ),
                titleTextStyle: TextStyle(
                  color: Color(0xFFC5C4C4),
                  fontFamily: 'MontSerrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                formatButtonVisible: false,
                titleCentered: true,
              ),
              rowHeight: 65.0,
              calendarStyle: const CalendarStyle(
                  tablePadding: EdgeInsets.only(top: 20.0),
                  defaultDecoration: BoxDecoration(color: Colors.purple)),
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) => dowText(day),
                prioritizedBuilder: (context, day, focusedDay) {
                  double percentual = 0.0;
                  String dia = '';
                  if (day.day < 10)
                    dia += "0${day.day}";
                  else
                    dia += "${day.day}";

                  String data = "${day.year}-${day.month}-${dia}";

                  if (percentuais.containsKey(data)) {
                    percentual = percentuais[data]!;
                  }

                  Color cor = Colors.black;

                  //|| day.isAfter(DateTime.now())
                  if (day.isBefore(tarefaMaisAntiga))
                    cor = Color(0xFFC5C4C4);
                  else if (percentual <= 0.35)
                    cor = Colors.red;
                  else if (percentual <= 0.7)
                    cor = Colors.orange;
                  else
                    cor = Colors.green;

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
                        child: Text(
                          "${day.day}",
                          style: TextStyle(
                            color: Color(0xFFC5C4C4),
                            fontFamily: "MontSerrat",
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      CircularPercentIndicator(
                        backgroundColor: Color(0xFFC5C4C4),
                        animation: false,
                        animationDuration: 800,
                        radius: 18.0,
                        lineWidth: 1.0,
                        percent: percentual,
                        center: Text(
                          '${(percentual * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontFamily: 'MontSerrat',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: cor,
                          ),
                        ),
                        progressColor: cor,
                      ),
                    ],
                  );
                },
              ),
            )
        ],
      ),
    );
  }

  dowText(DateTime date) {
    int diaDaSemana = date.weekday;
    String saida = '';
    switch (diaDaSemana) {
      case 1:
        saida = 'S';
        break;
      case 2:
        saida = 'T';
        break;
      case 3:
        saida = 'Q';
        break;
      case 4:
        saida = 'Q';
        break;
      case 5:
        saida = 'S';
        break;
      case 6:
        saida = 'S';
        break;
      case 7:
        saida = 'D';
        break;
      default:
        saida = 'err';
    }
    return Center(
      child: Text(
        saida,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'MontSerrat',
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.visible,
      ),
    );
  }

  // getPercent(DateTime day) async{
  //   double saida = await tarefas.getPercentMonth(day);
  //   return saida;
  // }
}
