import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // 👈 Importa Firebase
import 'src/screens/routes.dart';
import 'firebase_options.dart'; // 👈 Archivo generado automáticamente por FlutterFire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 👈 Necesario antes de inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // 👈 Configuración automática
  );
  runApp(const JydacleanApp());
}

class JydacleanApp extends StatelessWidget {
  const JydacleanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jydaclean',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF009CA8),
        useMaterial3: true,
      ),
      initialRoute: Routes.login,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
