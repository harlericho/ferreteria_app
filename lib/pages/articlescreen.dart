import 'package:flutter/material.dart';
import 'animatedcard.dart'; // Importamos la clase AnimatedCard desde un archivo separado
import '../database/database_helper.dart'; // Importar la clase de base de datos
import '../models/categoria.dart';
import '../models/producto.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  // Mapa para almacenar los materiales seleccionados globalmente
  Map<String, bool> _selectedMaterialsGlobal = {};

  // Listas para las categorías y productos
  List<Categoria> _categorias = [];
  Map<int, List<Producto>> _productosPorCategoria = {};

  // Mapa de categorías a imágenes
  final Map<String, String> categoriaImages = {
    'herramientas':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtdsUVyudKkqu0eYjb0GV50K5OcIUEu-K9oc9olZ0wbCwB-2PvTuf-OEkhZIDGWfc_Qxg&usqp=CAU', // Imagen para herramientas
    'baños':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0m1QFTWlfdZpsq1y6x23-0TNCgzvptHq8sA&s', // Imagen para baños
    'pinturas':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaf2lXR_22e4plE-4kEjv1eKy1lU1wzRkgOg&s', // Imagen para pinturas
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Cargar datos desde la base de datos
  Future<void> _loadData() async {
    final dbHelper = DatabaseHelper();

    // Obtener categorías
    List<Categoria> categorias = await dbHelper.getCategorias();

    // Obtener productos para cada categoría
    Map<int, List<Producto>> productosPorCategoria = {};
    for (Categoria categoria in categorias) {
      productosPorCategoria[categoria.id!] =
          await dbHelper.getProductosByCategoria(categoria.id!);
    }

    setState(() {
      _categorias = categorias;
      _productosPorCategoria = productosPorCategoria;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Artículos',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Título en negrita
          ),
        ),
        backgroundColor: Colors.orange, // Color naranja
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2, // Ocupa 2/3 de la pantalla para las tarjetas
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _categorias.length,
              itemBuilder: (context, index) {
                final categoria = _categorias[index];
                final productos = _productosPorCategoria[categoria.id!] ?? [];

                return buildAnimatedCard(
                  categoria.nombre,
                  'Explora nuestra selección de ${categoria.nombre}',
                  categoriaImages[categoria.nombre.toLowerCase()] ??
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-Azl_HN97MujdF1L0IpDwPtLzRxOPG3fW6w&s', // Imagen correspondiente a la categoría
                  productos.map((producto) => producto.nombre).toList(),
                );
              },
            ),
          ),
          Expanded(
            flex: 1, // Ocupa 1/3 de la pantalla para la lista de seleccionados
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Materiales Seleccionados:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: _selectedMaterialsGlobal.keys.map((material) {
                        return ListTile(
                          title: Text(material),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Función para crear una tarjeta animada
  Widget buildAnimatedCard(String title, String description, String imageUrl,
      List<String> materials) {
    return AnimatedCard(
      title: title,
      description: description,
      imageUrl: imageUrl,
      materials: materials,
      onMaterialSelected: (selectedMaterials) {
        setState(() {
          // Actualizamos los materiales seleccionados globalmente
          selectedMaterials.forEach((material, isSelected) {
            if (isSelected) {
              _selectedMaterialsGlobal[material] = true;
            } else {
              _selectedMaterialsGlobal.remove(material);
            }
          });
        });
      },
    );
  }
}
