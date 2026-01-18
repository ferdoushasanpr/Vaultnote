import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaultnote/screens/pin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ExoticNotesApp());
}

class ExoticNotesApp extends StatelessWidget {
  const ExoticNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exotic Notes',
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

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool? hasPin;

  @override
  void initState() {
    super.initState();
    _checkPinStatus();
  }

  _checkPinStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      hasPin = prefs.containsKey('user_pin');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hasPin == null)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    // If PIN doesn't exist, go to Setup. If it does, go to Login.
    return PinScreen(isSetup: !hasPin!);
  }
}
