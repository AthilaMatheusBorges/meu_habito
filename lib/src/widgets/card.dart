import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  const MyCard(
      {super.key,
      required this.nome,
      required this.horario,
      required this.icon,
      required this.checked,
      required this.index,
      required this.setCard});

  final String nome;
  final String horario;
  final String icon;
  final bool checked;
  final int index;
  final setCard;

  @override
  State<MyCard> createState() => _MyCard();
}

class _MyCard extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    bool _checked = widget.checked;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 100.0,
      child: GestureDetector(
        onTap: () {
          widget.setCard(widget.index);
        },
        child: Card(
          margin: EdgeInsets.only(bottom: 20.0),
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              color: _checked
                  ? Color(0xFF2AA50C)
                  : Color.fromARGB(255, 196, 197, 197),
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _checked ? Color(0xFF2AA50C) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _checked
                        ? Color(0xFF2AA50C)
                        : Color.fromARGB(255, 196, 197, 197),
                    width: 1.0,
                  ),
                ),
                child: !_checked
                    ? Image.asset(
                        widget.icon,
                        width: 30.0,
                        height: 30.0,
                      )
                    : Icon(
                        Icons.done,
                        color: Color(0xFFFFFFFF),
                      ),
              ), // Ícone à esquerda
              Container(
                width: 120.0,
                child: Text(
                  widget.nome,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: _checked
                          ? Color(0xFF2AA50C)
                          : Color.fromARGB(255, 59, 69, 245),
                      fontFamily: 'MontSerrat'),
                ),
              ),
              Text(
                widget.horario,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: _checked
                        ? Color(0xFF2AA50C)
                        : Color.fromARGB(255, 196, 197, 197),
                    fontFamily: 'MontSerrat'),
              ), // Horário à direita
            ],
          ),
        ),
      ),
    );
  }
}
