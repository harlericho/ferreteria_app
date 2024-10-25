import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visión y Misión',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Negrilla
          ),
        ),
        centerTitle: true, // Centrando el texto
        backgroundColor: Colors.orange, // Color tomate para el AppBar
      ),
      body: Container(
        color: Colors.white, // Fondo blanco
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // Contenedor de Visión
              FadeTransition(
                opacity: _animation,
                child: AnimatedContainer(
                  duration: Duration(seconds: 5),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 138, 137, 137)
                        .withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Visión',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(0, 0, 0, 0.986),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'En el 2025 CONSTRUYE FACIL espera mantenerse como la empresa más representativa en la comercialización de materiales para la construcción, incrementando su participación en el mercado, apoyados por un excelente grupo de proveedores, el compromiso de nuestros colaboradores y la fidelidad de nuestros clientes.',
                        textAlign: TextAlign.center, // Alineado al centro
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold, // Negrilla
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Contenedor de Misión
              FadeTransition(
                opacity: _animation,
                child: AnimatedContainer(
                  duration: Duration(seconds: 5),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 138, 137, 137)
                        .withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Misión',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(0, 0, 0, 0.986),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'En CONSTRUYE FACIL somos una empresa dedicada a la fabricación de hierro figurado y malla electrosoldada, compra, almacenamiento y comercialización de insumos para el sector de la construcción y productos para el hogar, que trabaja por brindar soluciones integrales para el beneficio de nuestros clientes y el desarrollo de la región; buscando satisfacer sus necesidades a través de la oferta de productos y servicios de la mejor calidad.',
                        textAlign: TextAlign.center, // Alineado al centro
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold, // Negrilla
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
