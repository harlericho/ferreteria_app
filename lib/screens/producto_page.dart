import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/categoria.dart';
import '../models/producto.dart';
import '../widgets/custom_dialog.dart';

class ProductosPage extends StatefulWidget {
  final Categoria categoria;

  ProductosPage({required this.categoria});

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  final dbHelper = DatabaseHelper();
  List<Producto> productos = [];

  @override
  void initState() {
    super.initState();
    _loadProductos();
  }

  Future<void> _loadProductos() async {
    final data = await dbHelper.getProductosByCategoria(widget.categoria.id!);
    setState(() {
      productos = data;
    });
  }

  Future<void> _addProducto() async {
    final nombre = await showCustomDialog(context, 'Nuevo Producto');
    if (nombre != null && nombre.isNotEmpty) {
      await dbHelper.insertProducto(
        Producto(nombre: nombre, categoriaId: widget.categoria.id!),
      );
      _loadProductos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos de ${widget.categoria.nombre}'),
      ),
      body: productos.isEmpty
          ? Center(child: Text('No hay productos en esta categoría.'))
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return ListTile(
                  title: Text(producto.nombre),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProducto,
        child: Icon(Icons.add),
      ),
    );
  }
}
