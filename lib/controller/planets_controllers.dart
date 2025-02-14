import 'package:flutter/material.dart';
import '../models/planets.dart'; // Importe seu modelo de Planeta
import '../database/database_helper.dart'; // Importe sua classe DatabaseHelper

class PlanetsController with ChangeNotifier {
  List<Planets> _planets = [];
  List<Planets> get planets => _planets;

  //Método construtor.
  PlanetsController() {
    _loadPlanets();
  }

  // Função assincrona para carregar os planetas do banco de dados.
  Future<void> _loadPlanets() async {
    _planets = (DatabaseHelper.instance.getPlanet) as List<Planets>;
    notifyListeners();
  }

  // Função para salvar um planeta
  Future<void> savePlanet(Planets planet) async {
    int id = await DatabaseHelper.instance.insertPlanet(planet);
    planet.id = id;
    _planets.add(planet);
    notifyListeners();
  }

  // Função para atualizar um planeta.
  Future<void> updatePlanet(Planets planet) async {
    await DatabaseHelper.instance.updatePlanet(planet);
    final index = _planets.indexWhere((p) => p.id == planet.id);
    if (index >= 0) {
      _planets[index] = planet;
      notifyListeners();
    }
  }

  // Função para deletar um planeta.
  Future<void> deletePlanet(int id) async {
    await DatabaseHelper.instance.deletePlanet(id);
    _planets.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
