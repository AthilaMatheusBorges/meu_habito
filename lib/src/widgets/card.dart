import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key, required this.nome, required this.horario, required this.icon});

  final String nome;
  final String horario;
  final String icon;

  @override
  State<MyCard> createState() => _MyCard();
}

class _MyCard extends State<MyCard> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 80,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0,
            color: Color.fromARGB(255, 196, 197, 197),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromARGB(255, 196, 197, 197),
                    width: 1.0,
                  ),
                ),
                child: Image.asset(
                  widget.icon, width: 30.0, height: 30.0,
                ),
              ), // Ícone à esquerda
              Container(
                width: 120.0,
                child: Text(
                  widget.nome,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 59, 69, 245),
                      fontFamily: 'MontSerrat'),
                ),
              ),
                  Text(
                    widget.horario,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 196, 197, 197),
                        fontFamily: 'MontSerrat'),
                  ), // Horário à direita
             
            ],
          ),
        ),
      ),
    );
  }
}