import 'package:flutter/material.dart';
import 'package:meu_habito/repositories/task_repository.dart';
import 'package:meu_habito/src/screens/pomodoro_page.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  
  late TaskRepository tarefas;
  
  @override
  Widget build(BuildContext context) {

    
    tarefas = context.watch<TaskRepository>();
    
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: 0.6,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              margin: EdgeInsets.zero,
              child: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'MontSerrat',
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF6C73F5),
              ),
            ),
            ListTile(
              leading: Icon(Icons.timer, color: Color(0xFF3B45F5),),
              title: Text(
                'Pomodoro',
                style: TextStyle(
                    fontFamily: 'MontSerrat',
                    color: Color(0xFF6C73F5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PomodoroPage(),
                        )
                      )
              },
            ),
            ListTile(
              leading: Icon(Icons.storage_rounded, color: Color(0xFF3B45F5),),
              title: Text(
                'Mockar',
                style: TextStyle(
                    fontFamily: 'MontSerrat',
                    color: Color(0xFF6C73F5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {tarefas.mockarDB(), Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xFF3B45F5),),
              title: Text(
                'Configurações',
                style: TextStyle(
                    fontFamily: 'MontSerrat',
                    color: Color(0xFF6C73F5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
            // ListTile(
            //   leading: Icon(Icons.border_color),
            //   title: Text('Feedback'),
            //   onTap: () => {Navigator.of(context).pop()},
            // ),
            // ListTile(
            //   leading: Icon(Icons.exit_to_app),
            //   title: Text('Logout'),
            //   onTap: () => {Navigator.of(context).pop()},
            // ),
          ],
        ),
      ),
    );
  }
}
