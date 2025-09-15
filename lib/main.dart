// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/login.dart'; // ← Importa la pantalla de login

void main() {
  runApp(const JydacleanApp());
}

class JydacleanApp extends StatelessWidget {
  const JydacleanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jydaclean',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const LoginScreen(), // ← Usa LoginScreen desde la nueva ubicación
      debugShowCheckedModeBanner: false,
    );
  }
}
