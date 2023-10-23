import 'package:flutter/material.dart';

class IconSelector extends StatefulWidget {
   IconSelector({required this.atualiza, required String this.selected});
  final atualiza;
  String selected;
  @override
  _IconSelectorState createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  final List<String> icons = [
    'assets/icons/caminhada.png',
    'assets/icons/croche.png',
    'assets/icons/de-costura.png',
    'assets/icons/degustacao-de-vinho.png',
    'assets/icons/desenhando.png',
    'assets/icons/escrita.png',
    'assets/icons/ginastica.png',
    'assets/icons/observacao-de-passaros.png',
    'assets/icons/pintura.png',
    'assets/icons/reparo-do-carro.png',
    //'icons/caminhada.png',
    // Adicione mais caminhos para os seus ícones aqui
  ];



  @override
  Widget build(BuildContext context) {

  String selectedIcon =  widget.selected;
    // if(widget.selected != ''){
    //   setState(() {
    //     selectedIcon = widget.selected;
    //   });
    // }

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
                  child: SizedBox(
                    height: 55,
                    width: 55,
                    child: ListTile(
                      //shape: CircleBorder(),
                      //tileColor: Colors.amber,
                      contentPadding: EdgeInsets.all(0),
                      onTap: () {
                        setState(() {
                          selectedIcon = icons[index];
                          widget.atualiza(icons[index]);
                          print(selectedIcon);
                        });
                      },
                      leading: SizedBox(
                        width: 45,
                        child: Container(
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
