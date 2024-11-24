class Producto {
  final int? id;
  final String nombre;
  final int categoriaId;

  Producto({this.id, required this.nombre, required this.categoriaId});

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      nombre: map['nombre'],
      categoriaId: map['categoriaId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'categoriaId': categoriaId,
    };
  }
}
