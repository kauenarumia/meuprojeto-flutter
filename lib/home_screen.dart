import 'package:flutter/material.dart';
import 'package:meuprojeto/dadoscadastraispage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página Inicial"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bem-vindo à HomeScreen!",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20), // Adiciona espaço entre os widgets
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 70),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => DadosCadastraisPage(), // Sem const aqui
                  ),
                );
              },
              child: const Text('Cadastrar Dados'),
            ),
          ],
        ),
      ),
    );
  }
}
