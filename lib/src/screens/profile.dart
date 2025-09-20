import 'package:flutter/material.dart';
import 'routes.dart'; // Importa las rutas

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  
  bool _mostrarTelefono = false;
  bool _modoEdicion = false;
  int _currentIndex = 3; // Perfil seleccionado

  @override
  void initState() {
    super.initState();
    nombreController.text = 'Juan Perez';
    usuarioController.text = 'PerJuan2025';
    correoController.text = 'Perez.Juan@gmail.com';
    telefonoController.text = '1234567890';
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return; // No navegar a la misma pantalla
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, Routes.catalogo);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, Routes.notification);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, Routes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA8),
        elevation: 0,
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con icono
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF009CA8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 70, color: Color(0xFF009CA8)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mi Perfil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            // Card con campos
            Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF009CA8),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildCampo('Nombre', nombreController, Icons.person),
                      const SizedBox(height: 20),
                      _buildCampo('Usuario', usuarioController, Icons.badge),
                      const SizedBox(height: 20),
                      _buildCampo('Correo electrónico', correoController, Icons.email),
                      const SizedBox(height: 20),
                      _buildCampoTelefono('Teléfono', telefonoController, Icons.phone),
                      const SizedBox(height: 30),
                      _modoEdicion ? _buildBotonGuardar() : _buildBotonModificar(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF009CA8),
        unselectedItemColor: const Color(0xFF9E9E9E),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home, color: Color(0xFF009CA8)),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart, color: Color(0xFF009CA8)),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            activeIcon: Icon(Icons.description, color: Color(0xFF009CA8)),
            label: 'Solicitudes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person, color: Color(0xFF009CA8)),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildCampo(String titulo, TextEditingController controller, IconData icono) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Icon(icono, color: const Color(0xFF009CA8), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: _modoEdicion
                      ? TextField(
                          controller: controller,
                          decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                          style: const TextStyle(fontSize: 16),
                        )
                      : Text(controller.text, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCampoTelefono(String titulo, TextEditingController controller, IconData icono) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Icon(icono, color: const Color(0xFF009CA8), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: _modoEdicion
                      ? TextField(
                          controller: controller,
                          decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                          style: const TextStyle(fontSize: 16),
                        )
                      : Text(_mostrarTelefono ? controller.text : '••••••••••', style: const TextStyle(fontSize: 16, color: Colors.black87)),
                ),
                if (!_modoEdicion)
                  IconButton(
                    icon: Icon(_mostrarTelefono ? Icons.visibility : Icons.visibility_off, color: const Color(0xFF009CA8), size: 20),
                    onPressed: () {
                      setState(() {
                        _mostrarTelefono = !_mostrarTelefono;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBotonModificar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => setState(() => _modoEdicion = true),
        child: const Text('Modificar', style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF009CA8),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildBotonGuardar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() => _modoEdicion = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cambios guardados correctamente'), backgroundColor: Color(0xFF8BC34A), duration: Duration(seconds: 2)),
          );
        },
        child: const Text('Guardar', style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8BC34A),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nombreController.dispose();
    usuarioController.dispose();
    correoController.dispose();
    telefonoController.dispose();
    super.dispose();
  }
}
