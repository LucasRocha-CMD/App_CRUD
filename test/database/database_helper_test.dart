// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/database/database_helper.dart';

void main() {
  // Garante que o binding esteja inicializado. Isso deve ser feito ANTES de usar
  // qualquer plugin que dependa de bindings, como o path_provider.
  TestWidgetsFlutterBinding.ensureInitialized();

  //inicializar o database
  DatabaseHelper.instance;

  group('DatabaseHelper', () {
    test('Deve criar um novo planeta', () async {
      final dbHelper = DatabaseHelper.instance;
      // ...
    });
    test('Deve obter todos os planetas', () async {
      final dbHelper = DatabaseHelper.instance;
      // ...
    });

    // ... outros testes
  });
}