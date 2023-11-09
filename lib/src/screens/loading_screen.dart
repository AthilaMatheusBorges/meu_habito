import 'package:flutter/material.dart';
import 'package:meu_habito/repositories/task_repository.dart';
import 'package:meu_habito/src/screens/home_page.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      // Após o carregamento, navegue para a tela principal
      // Substitua esse código pela navegação real que você deseja após o carregamento
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    });
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/meuhabito.png'),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: CircularProgressIndicator(
              color: Color(0xFF3B45F5),
            ),
          )
        ],
      ),
    );
  }
}
