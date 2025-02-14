// ignore_for_file: library_private_types_in_public_api

import '../database/database_helper.dart';
import '../models/planets.dart';
import '../screens/planets_edit.dart';
import 'package:flutter/material.dart';

class PlanetsList extends StatefulWidget {
  const PlanetsList({super.key});

  @override
  _PlanetsListState createState() => _PlanetsListState();
}

class _PlanetsListState extends State<PlanetsList> {
  List<Planets> _planets = [];

  @override
  void initState() {
    super.initState();
    _loadPlanets();
  }

  //Carregar planetas
  Future<void> _loadPlanets() async {
    List<Planets> planets = await DatabaseHelper.instance.getAllPlanets();
    setState(() {
      _planets = planets;
    });
  }

  //Excluir planetas
  Future<void> _deletePlanet(int id) async {
    await DatabaseHelper.instance.deletePlanet(id);
    _loadPlanets(); // Recarrega a lista após a exclusão
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Planetas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _planets.length,
          itemBuilder: (context, index) {
            Planets planet = _planets[index];
            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/planet_icon.png'), // Substitua pelo caminho da sua imagem
                ),
                title: Text(planet.nome),
                subtitle: Text(
                    'Distância: ${planet.distancia}, Tamanho: ${planet.tamanho}, Apelido: ${planet.apelido}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () =>
                      _deletePlanet(planet.id), // Passa o ID do planeta
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlanetsEdit(planet: planet)),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
