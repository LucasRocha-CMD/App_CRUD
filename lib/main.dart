import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/themenotifier.dart';// Importe o ThemeNotifier
import 'screens/main_menu.dart'; // Importe o MainMenu

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        return MaterialApp(
          title: 'Planetas App',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            scaffoldBackgroundColor: Colors.grey[200],
            textTheme: _buildTextTheme(ThemeData.light().textTheme), // Adicionado
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                inherit: true, // Assegure-se de que inherit é consistente
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 16,
                  inherit: true, // Assegure-se de que inherit é consistente
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            textTheme: _buildTextTheme(ThemeData.dark().textTheme), // Adicionado
          ),
          themeMode: theme.currentTheme,
          home: const MainMenu(), // Inicia com o MainMenu
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }

  // Função para construir TextTheme consistente
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      titleLarge: base.titleLarge?.copyWith(inherit: true),
      bodyLarge: base.bodyLarge?.copyWith(inherit: true),
      bodyMedium: base.bodyMedium?.copyWith(inherit: true),
      bodySmall: base.bodySmall?.copyWith(inherit: true),
      labelLarge: base.labelLarge?.copyWith(inherit: true),
      titleMedium: base.titleMedium?.copyWith(inherit: true),
      titleSmall: base.titleSmall?.copyWith(inherit: true),
      labelSmall: base.labelSmall?.copyWith(inherit: true),
    );
  }
}
