import 'package:flutter/material.dart';
import 'src/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jydaclean App',
      theme: ThemeData(
        primaryColor: const Color(0xFF009CA8),
        scaffoldBackgroundColor: const Color(0xFF009CA8),
      ),
      home: const LoginScreen(), // 👈 Ahora LoginScreen está importado correctamente
    );
  }
}