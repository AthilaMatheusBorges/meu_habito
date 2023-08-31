import 'package:flutter/material.dart';

import 'src/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              background: Color.fromARGB(255, 238, 245, 253)),
          useMaterial3: true,
        ),
        home: HomePage());
  }
}
