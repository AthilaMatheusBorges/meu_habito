import 'package:flutter/material.dart';

class IconSelector extends StatefulWidget {
  const IconSelector({required this.atualiza});
  final atualiza;
  @override
  _IconSelectorState createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              //color: Color.fromARGB(255, 238, 245, 253),
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFF6C73F5),
                width: 3.0,
              ),
            ),
            child: Image.asset(selectedIcon),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: ListTile(
                      //shape: CircleBorder(),
                      //tileColor: Colors.amber,
                      contentPadding: EdgeInsets.all(0),
                      onTap: () {
                        setState(() {
                          selectedIcon = icons[index];
                          widget.atualiza(icons[index]);
                        });
                      },
                      leading: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromARGB(255, 196, 197, 197),
                            width: 1.0,
                          ),
                        ),
                        child: Image.asset(
                          icons[index],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
