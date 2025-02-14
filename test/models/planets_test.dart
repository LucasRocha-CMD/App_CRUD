import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/planets.dart';

void main() {
  group('Planets', () {
    test('toMap deve retornar um mapa com os dados do planeta', () {
      final planet = Planets(
        id: 1,
        nome: 'Terra',
        tamanho: 12756.0,
        distancia: 149.6,
        apelido: 'Planeta Azul',
      );
      final expectedMap = {
        'id': 1,
        'nome': 'Terra',
        'tamanho': 12756.0,
        'distancia': 149.6,
        'apelido': 'Planeta Azul',
      };
      expect(planet.toMap(), expectedMap);
    });

    test('fromMap deve retornar um objeto Planets com os dados corretos', () {
      final map = {
        'id': 1,
        'nome': 'Terra',
        'tamanho': 12756.0,
        'distancia': 149.6,
        'apelido': 'Planeta Azul',
      };
      final expectedPlanet = Planets(
        id: 1,
        nome: 'Terra',
        tamanho: 12756.0,
        distancia: 149.6,
        apelido: 'Planeta Azul',
      );
      expect(Planets.fromMap(map), expectedPlanet);
    });

    test('Dois objetos Planets com os mesmos valores devem ser iguais', () {
            final planet1 = Planets(
        id: 1,
        nome: 'Terra',
        tamanho: 12756.0,
        distancia: 149.6,
        apelido: 'Planeta Azul',
      );
      final planet2 = Planets(
        id: 1,
        nome: 'Terra',
        tamanho: 12756.0,
        distancia: 149.6,
        apelido: 'Planeta Azul',
      );

      expect(planet1, planet2);
      expect(planet1.hashCode, planet2.hashCode); // Verifica também o hashCode
    });

    test('Dois objetos Planets com valores diferentes não devem ser iguais', () {
      final planet1 = Planets(
        id: 1,
        nome: 'Terra',
        tamanho: 12756.0,
        distancia: 149.6,
        apelido: 'Planeta Azul',
      );
      final planet2 = Planets(
        id: 2, // ID diferente
        nome: 'Terra',
        tamanho: 12756.0,
        distancia: 149.6,
        apelido: 'Planeta Azul',
      );

      expect(planet1, isNot(planet2));
      expect(planet1.hashCode, isNot(planet2.hashCode)); // Verifica também o hashCode
    });
  });
}