class Categoria {
  final int? id;
  final String nombre;

  Categoria({this.id, required this.nombre});

  // Convertir de Map a objeto
  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'],
      nombre: map['nombre'],
    );
  }

  // Convertir de objeto a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}
