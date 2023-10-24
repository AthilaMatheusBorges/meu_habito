import 'package:flutter/material.dart';
import 'package:meu_habito/configs/hive_config.dart';
import 'package:meu_habito/provider/tasks.dart';
import 'package:meu_habito/repositories/task_repository.dart';
import 'package:provider/provider.dart';

import 'src/screens/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await HiveConfig.start();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (ctx) => Tarefas(),
        // ),
        ChangeNotifierProvider(
          create: (ctx) => TaskRepository(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                background: Color.fromARGB(255, 238, 245, 253)),
            useMaterial3: true,
          ),
          //edit
          home: HomePage()),
    );
  }
}
