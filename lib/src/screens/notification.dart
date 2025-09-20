import 'package:flutter/material.dart';
import 'routes.dart';

class NotificacionesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notificaciones = [
    {
      "titulo": "Has solicitado la compra de Detergente",
      "fecha": "Hace 1 día",
      "productos": ["Detergente", "Suavizante", "Cloro"]
    },
    {
      "titulo": "Has solicitado la compra de Escoba",
      "fecha": "Hace 2 días",
      "productos": ["Escoba", "Trapeador"]
    },
    {
      "titulo": "Tenemos esta gran promoción",
      "fecha": "Hace 3 días",
      "productos": []
    },
  ];

  @override
  Widget build(BuildContext context) {
    final solicitudes =
        notificaciones.where((n) => n["productos"].isNotEmpty).toList();
    final promociones =
        notificaciones.where((n) => n["productos"].isEmpty).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        appBar: AppBar(
          backgroundColor: const Color(0xFF009CA8),
          title: const Text(
            "Notificaciones",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Solicitudes"),
              Tab(text: "Promociones"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Lista de Solicitudes
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: solicitudes.length,
              itemBuilder: (context, index) {
                final notif = solicitudes[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.solicitudes,
                      arguments: notif["productos"],
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/img/jydaclean.jpeg',
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notif["titulo"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notif["fecha"],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                  ),
                                ),
                                if (notif["productos"].isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: -6,
                                    children: notif["productos"]
                                        .map<Widget>((p) => Chip(
                                              label: Text(
                                                p,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              backgroundColor: Colors.grey[200],
                                            ))
                                        .toList(),
                                  ),
                                ]
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // Lista de Promociones
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: promociones.length,
              itemBuilder: (context, index) {
                final promo = promociones[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/img/jydaclean.jpeg',
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              promo["titulo"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              promo["fecha"],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xFF009CA8),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long), label: "Pedidos"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          ],
        ),
      ),
    );
  }
}

