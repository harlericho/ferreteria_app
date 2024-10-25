import 'package:flutter/material.dart';
import 'animatedcard.dart'; // Importamos la clase AnimatedCard desde un archivo separado

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  // Mapa para almacenar los materiales seleccionados globalmente
  Map<String, bool> _selectedMaterialsGlobal = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Articulos',
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
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                buildAnimatedCard(
                  'HERRAMIENTAS',
                  'Las mejores herramientas para tu hogar',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtdsUVyudKkqu0eYjb0GV50K5OcIUEu-K9oc9olZ0wbCwB-2PvTuf-OEkhZIDGWfc_Qxg&usqp=CAU',
                  ['Martillo', 'Taladro', 'Destornillador'],
                ),
                buildAnimatedCard(
                  'BAÑOS',
                  'Opciones para la decoración de tu baño soñado',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0m1QFTWlfdZpsq1y6x23-0TNCgzvptHq8sA&s',
                  ['Azulejos', 'Grifo', 'Espejo'],
                ),
                buildAnimatedCard(
                  'PINTURAS',
                  'Pinturas para darle color a tu hogar',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaf2lXR_22e4plE-4kEjv1eKy1lU1wzRkgOg&s',
                  ['Pintura blanca', 'Rodillo', 'Brocha'],
                ),
              ],
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
