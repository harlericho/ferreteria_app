import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/categoria.dart';
import './producto_page.dart';
import '../widgets/custom_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper();

  List<Categoria> categorias = [];

  @override
  void initState() {
    super.initState();
    _loadCategorias();
  }

  Future<void> _loadCategorias() async {
    final data = await dbHelper.getCategorias();
    setState(() {
      categorias = data;
    });
  }

  void _navigateToProductos(Categoria categoria) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductosPage(categoria: categoria),
      ),
    );
  }

  Future<void> _addCategoria() async {
    final nombre = await showCustomDialog(context, 'Nueva Categoría');
    if (nombre != null && nombre.isNotEmpty) {
      final nombreMinuscula = nombre.toLowerCase();
      await dbHelper.insertCategoria(Categoria(nombre: nombreMinuscula));
      _loadCategorias();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categorías')),
      body: categorias.isEmpty
          ? Center(child: Text('No hay categorías. Añade una.'))
          : ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                return ListTile(
                  title: Text(categoria.nombre),
                  onTap: () => _navigateToProductos(categoria),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategoria,
        child: Icon(Icons.add),
      ),
    );
  }
}
