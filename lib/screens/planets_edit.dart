import '../database/database_helper.dart';
import '../models/planets.dart';
import 'package:flutter/material.dart';

class PlanetsEdit extends StatefulWidget {
  final Planets planet;
  const PlanetsEdit({super.key, required this.planet});

  @override
  State<PlanetsEdit> createState() => _PlanetsEditState();
}

class _PlanetsEditState extends State<PlanetsEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _tamanhoController;
  late TextEditingController _distanciaController;
  late TextEditingController _apelidoController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.planet.nome);
    _tamanhoController = TextEditingController(text: widget.planet.tamanho.toString());
    _distanciaController = TextEditingController(text: widget.planet.distancia.toString());
    _apelidoController = TextEditingController(text: widget.planet.apelido);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _tamanhoController.dispose();
    _distanciaController.dispose();
    _apelidoController.dispose();
    super.dispose();
  }

  void _updatePlanet() async {
    if (_formKey.currentState!.validate()) {
      Planets updatedPlanet = Planets(
        id: widget.planet.id,
        nome: _nomeController.text,
        tamanho: double.parse(_tamanhoController.text),
        distancia: double.parse(_distanciaController.text),
        apelido: _apelidoController.text,
      );
      await DatabaseHelper.instance.updatePlanet(updatedPlanet);
      if (mounted){
              Navigator.pop(context); // Volta para a lista de planetas
      }
    }
  }

  @override
  Widget
 build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Planeta'),
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
                  onPressed: _updatePlanet,
                  child: const Text('Atualizar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
