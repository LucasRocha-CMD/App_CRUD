import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/database/database_helper.dart';
import 'package:myapp/main.dart';
import 'package:myapp/providers/themenotifier.dart'; // Importe o ThemeNotifier
import 'package:myapp/screens/planets_forms.dart';
import 'package:myapp/screens/planets_list.dart';
import 'package:provider/provider.dart';

void main() {
  // Garante que o binding esteja inicializado. Isso deve ser feito ANTES de usar
  // qualquer plugin que dependa de bindings, como o path_provider.
  TestWidgetsFlutterBinding.ensureInitialized();

  // Inicializa o database
  DatabaseHelper.instance;

  Widget createTestableWidget(Widget child) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Verifica se o Menu Principal é Exibido Corretamente', (WidgetTester tester) async {
    // Constrói o widget MyApp e todos os seus filhos.
    await tester.pumpWidget(createTestableWidget(const MyApp()));

    // Verifica se os botões "Adicionar Planeta" e "Listar Planetas" estão presentes.
    expect(find.text('Adicionar Planeta'), findsOneWidget);
    expect(find.text('Listar Planetas'), findsOneWidget);
  });

  testWidgets('Navegação para PlanetsForms', (WidgetTester tester) async {
    // Constrói o widget MyApp e todos os seus filhos.
    await tester.pumpWidget(createTestableWidget(const MyApp()));

    // Encontra o botão "Adicionar Planeta".
    final addButton = find.text('Adicionar Planeta');

    // Verifica se o botão "Adicionar Planeta" está visível.
    expect(addButton, findsOneWidget);

    // Toca no botão "Adicionar Planeta".
    await tester.tap(addButton);

    // Aguarda a animação e a transição de tela.
    await tester.pumpAndSettle();

    // Verifica se a tela PlanetsForms foi exibida.
    expect(find.byType(PlanetsForms), findsOneWidget);
  });

  testWidgets('Navegação para PlanetsList', (WidgetTester tester) async {
    // Constrói o widget MyApp e todos os seus filhos.
    await tester.pumpWidget(createTestableWidget(const MyApp()));

    // Encontra o botão "Listar Planetas".
    final listButton = find.text('Listar Planetas');

    // Verifica se o botão "Listar Planetas" está visível.
    expect(listButton, findsOneWidget);

    // Toca no botão "Listar Planetas".
    await tester.tap(listButton);

    // Aguarda a animação e a transição de tela.
    await tester.pumpAndSettle();

    // Verifica se a tela PlanetsList foi exibida.
    expect(find.byType(PlanetsList), findsOneWidget);
  });
}
