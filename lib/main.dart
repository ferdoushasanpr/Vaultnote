import 'package:flutter/material.dart';
import 'package:vaultnote/screens/pin_screen.dart';

void main() {
  runApp(const ExoticNotesApp());
}

class ExoticNotesApp extends StatelessWidget {
  const ExoticNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vault Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(
          0xFF0D0221,
        ), // Deep Dark Blue/Purple
        primaryColor: const Color(0xFF00FFC8), // Neon Teal
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFC8),
          secondary: Color(0xFFFFD700), // Gold
          surface: Color(0xFF19112E),
        ),
        textTheme: const TextTheme(
          displayMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: Colors.white70),
        ),
      ),
      home: const AuthCheck(),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return PinScreen();
  }
}
