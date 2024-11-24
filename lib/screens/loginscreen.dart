import 'package:flutter/material.dart';
import '../database/dbuser.dart';
import './registerscreen.dart';
import './home_page.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Ferreteria',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Título en negrita
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Email de Usuario',
                prefixIcon: Icon(Icons.email), // Icono del campo de email
                border: OutlineInputBorder(), // Añadir borde
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock), // Icono del campo de contraseña
                border: OutlineInputBorder(), // Añadir borde
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final username = usernameController.text.trim();
                final password = passwordController.text.trim();
                final user =
                    await DBUser.instance.loginUser(username, password);
                if (user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Ingreso exitoso. Bienvenido $username')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciales incorrectas')),
                  );
                }
              },
              icon: Icon(Icons.login), // Icono del botón
              label: Text('Iniciar Sesión'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('¿No tienes cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
