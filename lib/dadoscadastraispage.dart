import 'package:flutter/material.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  final nomeController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  DateTime? dataNascimento;

  List<String> niveis = [
    'Estágio',
    'Júnior',
    'Pleno',
    'Sênior',
    'Especialista',
  ];
  List<String> linguagens = ['Dart', 'Java', 'C#', 'Python', 'JavaScript'];

  List<String> linguagensSelecionadas = [];
  String nivelSelecionado = '';
  double salarioEscolhido = 0;
  int tempoExperiencia = 0;

  bool salvando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradiente no background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child:
              salvando
                  ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 10,
                      color: Colors.white.withOpacity(0.95),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                'Formulário de Cadastro',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller: nomeController,
                              decoration: InputDecoration(
                                labelText: 'Nome',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.deepPurple,
                                ),
                                filled: true,
                                fillColor: Colors.deepPurple.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: dataNascimentoController,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Data de Nascimento',
                                prefixIcon: Icon(
                                  Icons.cake,
                                  color: Colors.pink,
                                ),
                                filled: true,
                                fillColor: Colors.pink.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onTap: () async {
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    dataNascimento = pickedDate;
                                    dataNascimentoController.text =
                                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value:
                                  nivelSelecionado.isEmpty
                                      ? null
                                      : nivelSelecionado,
                              items:
                                  niveis.map((nivel) {
                                    return DropdownMenuItem(
                                      value: nivel,
                                      child: Text(nivel),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() => nivelSelecionado = value!);
                              },
                              decoration: InputDecoration(
                                labelText: 'Nível',
                                prefixIcon: Icon(
                                  Icons.grade,
                                  color: Colors.orange,
                                ),
                                filled: true,
                                fillColor: Colors.orange.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Linguagens que domina:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 10,
                                  children:
                                      linguagens.map((linguagem) {
                                        return FilterChip(
                                          label: Text(linguagem),
                                          selected: linguagensSelecionadas
                                              .contains(linguagem),
                                          selectedColor:
                                              Colors.lightGreen.shade200,
                                          checkmarkColor: Colors.green.shade900,
                                          onSelected: (bool selecionado) {
                                            setState(() {
                                              if (selecionado) {
                                                linguagensSelecionadas.add(
                                                  linguagem,
                                                );
                                              } else {
                                                linguagensSelecionadas.remove(
                                                  linguagem,
                                                );
                                              }
                                            });
                                          },
                                        );
                                      }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Salário desejado: R\$ ${salarioEscolhido.toStringAsFixed(2)}',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Slider(
                                  value: salarioEscolhido,
                                  onChanged: (value) {
                                    setState(() => salarioEscolhido = value);
                                  },
                                  min: 0,
                                  max: 20000,
                                  divisions: 100,
                                  activeColor: Colors.teal,
                                  label:
                                      'R\$ ${salarioEscolhido.toStringAsFixed(0)}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tempo de experiência: $tempoExperiencia anos',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Slider(
                                  value: tempoExperiencia.toDouble(),
                                  onChanged: (value) {
                                    setState(
                                      () => tempoExperiencia = value.toInt(),
                                    );
                                  },
                                  min: 0,
                                  max: 30,
                                  divisions: 30,
                                  activeColor: Colors.indigo,
                                  label: '$tempoExperiencia anos',
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() => salvando = true);
                                Future.delayed(const Duration(seconds: 2), () {
                                  setState(() => salvando = false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Dados salvos com sucesso!',
                                      ),
                                    ),
                                  );
                                });
                              },
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text("Salvar"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
