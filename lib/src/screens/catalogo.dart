import 'package:flutter/material.dart';
import 'profile.dart'; 

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
  int _currentIndex = 1; // Índice para resaltar Catálogo

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
      result = result.where((product) => product['category'] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      result = result.where((product) => 
          product['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          product['description'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filtrar Productos', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text('Categorías', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  // Función para manejar la navegación entre pantallas
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navegación entre pantallas
    if (index == 0) {
      // Navegar a Inicio
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else if (index == 1) {
      // Ya estamos en Catálogo,
    } else if (index == 2) {
      // Navegar a Solicitudes 
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RequestsScreen()));
    } else if (index == 3) {
      // Navegar a Perfil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PerfilPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009CA8),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilterDialog,
            tooltip: 'Filtrar productos',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: 'Buscar productos...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          if (selectedCategory != 'Todos')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text('Filtrado por: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Chip(
                    label: Text(selectedCategory),
                    backgroundColor: const Color(0xFF009CA8).withOpacity(0.2),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'Todos';
                        _applyFilters();
                      });
                    },
                    child: const Text('Limpiar filtro', style: TextStyle(color: Color(0xFF009CA8))),
                  )
                ],
              ),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: RefreshIndicator(
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
                          Icon(Icons.search_off, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No se encontraron productos', 
                               style: TextStyle(fontSize: 18, color: Colors.grey)),
                          SizedBox(height: 8),
                          Text('Intenta con otros términos de búsqueda', 
                               style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  : GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: filteredProducts.length + 1,
                      itemBuilder: (context, index) {
                        if (index < filteredProducts.length) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      filteredProducts[index]["image"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    filteredProducts[index]["name"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 14),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    filteredProducts[index]["price"],
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF8BC34A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      minimumSize: const Size(double.infinity, 36),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Solicitar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return loadedItems < allProducts.length
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox.shrink();
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF009CA8),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // Usamos la función de navegación
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Catálogo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Solicitudes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}