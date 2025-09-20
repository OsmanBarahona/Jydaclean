import 'package:flutter/material.dart';
import 'routes.dart'; // Importa las rutas

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        break; // Ya estamos en Home
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
      backgroundColor: const Color(0xFFE6F0F2), // fondo suave de empresa
      appBar: AppBar(
        backgroundColor: const Color(0xFF009CA8),
        title: const Text('Inicio', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.notification);
            },
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _HomeHeader()),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(child: _PromoBanner()),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),
            SliverToBoxAdapter(child: _SearchBar()),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 88,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    SizedBox(width: 4),
                    CategoryChip(icon: Icons.home_outlined, label: 'Hogar'),
                    CategoryChip(icon: Icons.apartment, label: 'Negocios'),
                    CategoryChip(icon: Icons.factory_outlined, label: 'Industria'),
                    CategoryChip(icon: Icons.eco_outlined, label: 'Ecológicos'),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            const SliverToBoxAdapter(child: _SectionTitle('Productos destacados')),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = demoProducts[index % demoProducts.length];
                    return ProductCard(product: product);
                  },
                  childCount: demoProducts.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 36)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF009CA8),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF8BC34A),
        unselectedItemColor: Colors.white70,
        currentIndex: 0,
        onTap: (index) => _navigateToScreen(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Catálogo"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Solicitudes"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}

/// Header: logo + nombre empresa
class _HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF009CA8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.cleaning_services, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Text('Jydaclean', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.notification);
            },
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF009CA8)),
          ),
        ],
      ),
    );
  }
}

/// Promo banner
class _PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 130,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8F1FF), Color(0xFFD1E7FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -6,
                bottom: -6,
                child: Opacity(
                  opacity: 0.18,
                  child: Icon(Icons.local_laundry_service, size: 160, color: Colors.blueGrey),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PROMOCIÓN DE LA SEMANA', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('20% OFF', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                    SizedBox(height: 4),
                    Text('en desinfectantes'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Search bar
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar productos...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        ),
        onSubmitted: (value) {},
      ),
    );
  }
}

/// Category chip
class CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const CategoryChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 6, bottom: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Container(
          width: 120,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF009CA8)),
              const SizedBox(height: 6),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF009CA8))),
            ],
          ),
        ),
      ),
    );
  }
}

/// Section title
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
    );
  }
}

/// Product model & demo list
class Product {
  final String name;
  final double price;
  final Color color;
  final String category;
  const Product({required this.name, required this.price, required this.color, required this.category});
}

const demoProducts = <Product>[
  Product(name: 'Limpiador Multiusos', price: 120, color: Color(0xFFFFD54F), category: 'Hogar'),
  Product(name: 'Detergente Líquido', price: 95, color: Color(0xFF64B5F6), category: 'Hogar'),
  Product(name: 'Desinfectante', price: 110, color: Color(0xFF81C784), category: 'Negocios'),
  Product(name: 'Suavizante', price: 85, color: Color(0xFFBA68C8), category: 'Hogar'),
  Product(name: 'Desengrasante Industrial', price: 180, color: Color(0xFFFF8A65), category: 'Industria'),
  Product(name: 'Cloro Gel', price: 70, color: Color(0xFFAED581), category: 'Industria'),
];

String formatPrice(double v) => v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(2);

/// Product card widget
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: product.color.withOpacity(0.95), borderRadius: BorderRadius.circular(12)),
                child: const Center(child: Icon(Icons.local_drink, size: 46, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10),
            Align(alignment: Alignment.centerLeft, child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.w700), maxLines: 2, overflow: TextOverflow.ellipsis)),
            const SizedBox(height: 6),
            Align(alignment: Alignment.centerLeft, child: Text('L. ${formatPrice(product.price)}', style: const TextStyle(fontWeight: FontWeight.w600))),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8BC34A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => _RequestSheet(product: product),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Solicitar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom sheet de solicitud
class _RequestSheet extends StatelessWidget {
  final Product product;
  const _RequestSheet({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Solicitar: ${product.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          TextField(decoration: const InputDecoration(labelText: 'Nombre completo')),
          const SizedBox(height: 8),
          TextField(decoration: const InputDecoration(labelText: 'Dirección de envío')),
          const SizedBox(height: 8),
          TextField(decoration: const InputDecoration(labelText: 'Teléfono (opcional)')),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Enviar solicitud'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
