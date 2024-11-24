import 'package:flutter/material.dart';

class AnimatedCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> materials;
  final Function(Map<String, bool>)
      onMaterialSelected; // Callback para materiales seleccionados

  AnimatedCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.materials,
    required this.onMaterialSelected,
  });

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  double _elevation = 5;
  Color _color = Colors.white;
  double _opacity = 1.0;
  bool _isSelected = false;
  double _descriptionHeight = 0;
  Map<String, bool> _selectedMaterials =
      {}; // Estado de selección de materiales

  @override
  void initState() {
    super.initState();
    // Inicializamos los materiales no seleccionados
    widget.materials.forEach((material) {
      _selectedMaterials[material] = false;
    });
  }

  void _onTap() {
    setState(() {
      _elevation = _elevation == 5 ? 10 : 5;
      _color = _color == Colors.white
          ? const Color.fromARGB(255, 241, 119, 70)
          : Colors.white;
      _opacity = _opacity == 1.0 ? 0.7 : 1.0;
      _isSelected = !_isSelected;
      _descriptionHeight =
          _isSelected ? 200 : 0; // Ajustamos la altura para mostrar la lista
    });

    final snackBar = SnackBar(
      content: Text(_isSelected
          ? '${widget.title} seleccionado'
          : '${widget.title} deseleccionado'),
      duration: Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onMaterialChecked(String material, bool? isChecked) {
    setState(() {
      _selectedMaterials[material] = isChecked!;
    });

    // Solo llamar al callback si el estado ha cambiado
    widget.onMaterialSelected(Map.from(_selectedMaterials));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 300),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: _elevation,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    widget.imageUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _descriptionHeight, // Altura animada
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _isSelected
                        ? Column(
                            children: [
                              Text(
                                widget.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: widget.materials.length,
                                  itemBuilder: (context, index) {
                                    final material = widget.materials[index];
                                    return CheckboxListTile(
                                      title: Text(material),
                                      value: _selectedMaterials[material],
                                      onChanged: (bool? value) {
                                        _onMaterialChecked(material, value);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
