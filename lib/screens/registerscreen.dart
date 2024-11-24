import 'package:flutter/material.dart';
import '../database/dbuser.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro Ferreteria',
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
                if (username.isNotEmpty && password.isNotEmpty) {
                  await DBUser.instance.registerUser(username, password);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuario registrado con éxito')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Por favor, complete todos los campos')),
                  );
                }
              },
              icon: Icon(Icons.person_add), // Icono del botón de registro
              label: Text('Registrar'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
