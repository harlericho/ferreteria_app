import 'dart:async'; // Import necesario para usar Timer
import 'package:flutter/material.dart';
import './pages/about.dart';
import './pages/contact.dart';
import './pages/articlescreen.dart';
import './screens/loginscreen.dart'; // Asegúrate de importar la pantalla de login

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ferretería CONTRUYE FACIL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CONTRUYE FACIL'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _opacity = 1.0; // Opacidad inicial

  @override
  void initState() {
    super.initState();
    _startFadeEffect(); // Iniciar el efecto de parpadeo
  }

  void _startFadeEffect() {
    Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      setState(() {
        _opacity = _opacity == 1.0 ? 0.0 : 1.0; // Alternar entre 1.0 y 0.0
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.person), // Ícono de usuario
            tooltip: 'Login',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                const SizedBox(height: 20),
                Image.asset(
                  'assets/logo.jpg',
                  width: 300,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bienvenido a Ferretería CONTRUYE FACIL, tu lugar de confianza para todo lo relacionado con herramientas y materiales de construcción.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildAnimatedButton(
                  context,
                  'Sobre Nosotros',
                  Icons.info_outline,
                  const About(),
                ),
                const SizedBox(height: 20),
                _buildAnimatedButton(
                  context,
                  'Contactos',
                  Icons.contact_page_outlined,
                  const Contact(),
                ),
                const SizedBox(height: 20),
                _buildAnimatedButton(
                  context,
                  'Articulos',
                  Icons.article_outlined,
                  const ArticleScreen(),
                ),
              ],
            ),
          ),
          // Texto de copyright con animación de parpadeo
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '© 2024 Ferretería CONTRUYE FACIL. Todos los derechos reservados.',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton(
    BuildContext context,
    String text,
    IconData icon,
    Widget page,
  ) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 1.0, end: 1.1),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page), // Usar push aquí
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(text),
              ],
            ),
          ),
        );
      },
    );
  }
}
