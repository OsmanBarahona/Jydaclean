import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil de Usuario',
      theme: ThemeData(
        primaryColor: Color(0xFF009CA8),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PerfilPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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

  @override
  void initState() {
    super.initState();
    // Valores iniciales de ejemplo
    nombreController.text = 'Juan Perez';
    usuarioController.text = 'PerJuan2025';
    correoController.text = 'Perez.Juan@gmail.com';
    telefonoController.text = '1234567890';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA8),
        elevation: 0,
        title: Text(
          'Perfil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sección superior con icono de perfil
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xFF009CA8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Color(0xFF009CA8),
                    ),
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
            
            // Contenedor de los campos de entrada con fondo decorativo
            Stack(
              children: [
                // Fondo azul/verde detrás del card
                Container(
                  height: 120,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFF009CA8),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                ),
                
                // Card con los inputs
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
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
                      SizedBox(height: 20),
                      _buildCampo('Usuario', usuarioController, Icons.badge),
                      SizedBox(height: 20),
                      _buildCampo('Correo electronico', correoController, Icons.email),
                      SizedBox(height: 20),
                      _buildCampoTelefono('Telefono', telefonoController, Icons.phone),
                      SizedBox(height: 30),
                      _modoEdicion ? _buildBotonGuardar() : _buildBotonModificar(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCampo(String titulo, TextEditingController controller, IconData icono) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
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
                Icon(icono, color: Color(0xFF009CA8), size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: _modoEdicion
                      ? TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 16),
                        )
                      : Text(
                          controller.text,
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
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
        Text(
          titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
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
                Icon(icono, color: Color(0xFF009CA8), size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: _modoEdicion
                      ? TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 16),
                          obscureText: !_mostrarTelefono,
                        )
                      : Text(
                          _mostrarTelefono ? controller.text : '••••••••••',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                ),
                if (!_modoEdicion)
                  IconButton(
                    icon: Icon(
                      _mostrarTelefono ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xFF009CA8),
                      size: 20,
                    ),
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
        onPressed: () {
          setState(() {
            _modoEdicion = true;
          });
        },
        child: Text('Modificar', style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF009CA8),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildBotonGuardar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _modoEdicion = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cambios guardados correctamente'),
              backgroundColor: Color(0xFF8BC34A),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Text('Guardar', style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8BC34A),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 3, // Perfil seleccionado
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF009CA8),
      unselectedItemColor: Color(0xFF9E9E9E),
      items: [
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
      onTap: (index) {
        // Navegación entre pantallas
        if (index == 0) {
          // Navegar a Inicio
        } else if (index == 1) {
          // Navegar a Catálogo
        } else if (index == 2) {
          // Navegar a Solicitudes
        }
        // Perfil
      },
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