
import '../database/database_helper.dart';
import '../models/planets.dart';
import 'package:flutter/material.dart';

class PlanetsForms extends StatefulWidget {
  const PlanetsForms({super.key});

  @override
  State<PlanetsForms> createState() => _PlanetsFormsState();
}

class _PlanetsFormsState extends State<PlanetsForms> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _tamanhoController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();

  // Função para salvar
  void _savePlanet() async {
    if (_formKey.currentState!.validate()) {
      Planets planeta = Planets(
        nome: _nomeController.text,
        tamanho: double.parse(_tamanhoController.text),
        distancia: double.parse(_distanciaController.text),
        apelido: _apelidoController.text, id: 0,
      );

      int id = await DatabaseHelper.instance.insertPlanet(planeta);
      setState(() {
        planeta.id = id; // Atualize o ID do planeta com o ID gerado pelo banco
      });

      // Limpa os campos depois de salvar.
      _nomeController.clear();
      _tamanhoController.clear();
      _distanciaController.clear();
      _apelidoController.clear();
       if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Planeta salvo com sucesso!')),
      );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Planeta'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite um nome';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _tamanhoController,
                  decoration: const InputDecoration(labelText: 'Tamanho'),
                  validator: (value) {
                    if (double.tryParse(value!) == null) {
                      return 'Por favor, digite um número válido';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _distanciaController,
                  decoration: const InputDecoration(labelText: 'Distância'),
                  validator: (value) {
                    if (double.tryParse(value!) == null) {
                      return 'Por favor, digite um número válido';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _apelidoController,
                  decoration: const InputDecoration(labelText: 'Apelido'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _savePlanet,
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
