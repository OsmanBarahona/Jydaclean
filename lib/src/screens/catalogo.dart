import 'package:flutter/material.dart';
import 'routes.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> filteredProducts = [];
  int loadedItems = 6;
  final int increment = 6;
  String selectedCategory = 'Todos';
  String searchQuery = '';
  int _currentIndex = 1;

  final List<Map<String, dynamic>> allProducts = List.generate(30, (index) {
    final categories = ['Hogar', 'Negocios', 'Industria'];
    final category = categories[index % categories.length];
    return {
      "name": "Producto ${index + 1}",
      "description": "Descripción del producto ${index + 1} para $category",
      "price": "L. ${(index + 1) * 10}",
      "category": category,
      "image": "https://via.placeholder.com/150x150.png?text=P${index + 1}"
    };
  });

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  void _loadProducts() {
    setState(() {
      products = allProducts.take(loadedItems).toList();
      _applyFilters();
    });
  }

  void _loadMore() {
    if (loadedItems < allProducts.length) {
      setState(() {
        loadedItems += increment;
        products = allProducts.take(loadedItems).toList();
        _applyFilters();
      });
    }
  }

  void _applyFilters() {
    List<Map<String, dynamic>> result = products;
    if (selectedCategory != 'Todos') {
      result = result.where((p) => p['category'] == selectedCategory).toList();
    }
    if (searchQuery.isNotEmpty) {
      result = result
          .where((p) =>
              p['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
              p['description']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }
    filteredProducts = result;
  }

  void _onSearch(String query) {
    setState(() {
      searchQuery = query;
      _applyFilters();
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filtrar Productos',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text('Categorías',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                ...['Todos', 'Hogar', 'Negocios', 'Industria'].map((category) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(category),
                    trailing: selectedCategory == category
                        ? const Icon(Icons.check, color: Color(0xFF009CA8))
                        : null,
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                        _applyFilters();
                      });
                      Navigator.of(context).pop();
                    },
                  );
                }).toList(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.home);
        break;
      case 1:
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
      backgroundColor: const Color(0xFF009CA8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009CA8),
        elevation: 0,
        title: const Text('Catálogo'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: 'Buscar productos...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Chip de categoría seleccionada
          if (selectedCategory != 'Todos')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text('Filtrado por: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Chip(
                    label: Text(selectedCategory),
                    backgroundColor: Colors.white,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'Todos';
                        _applyFilters();
                      });
                    },
                    child: const Text('Limpiar filtro',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),

          // Grid de productos
          Expanded(
            child: RefreshIndicator(
              color: const Color(0xFF8BC34A),
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  loadedItems = 6;
                  products = allProducts.take(loadedItems).toList();
                  _applyFilters();
                });
              },
              child: filteredProducts.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off,
                              size: 64, color: Colors.white70),
                          SizedBox(height: 16),
                          Text('No se encontraron productos',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70)),
                        ],
                      ),
                    )
                  : GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: filteredProducts.length + 1,
                      itemBuilder: (context, index) {
                        if (index < filteredProducts.length) {
                          final product = filteredProducts[index];
                          return Card(
                            color: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.grey.shade200)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: Image.network(product["image"],
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product["name"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.black87),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    product["price"],
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF8BC34A),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      minimumSize:
                                          const Size(double.infinity, 36),
                                    ),
                                    onPressed: () {},
                                    child: const Text("Solicitar",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return loadedItems < allProducts.length
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ),
                                )
                              : const SizedBox.shrink();
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF009CA8),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF8BC34A), // verde para resaltar
        unselectedItemColor: Colors.white70, // blanco semitransparente
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Catálogo"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: "Solicitudes"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
