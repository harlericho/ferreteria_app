import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return RegistroForm();
  }
}

class RegistroForm extends StatefulWidget {
  @override
  _RegistroFormState createState() => _RegistroFormState();
}

class _RegistroFormState extends State<RegistroForm> {
  final _formKey = GlobalKey<FormState>();
  String? _usuario;
  String? _clave;
  String? _email;
  String? _celular;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registro exitoso: $_usuario'),
          backgroundColor: Colors.green,
        ),
      );
      // Aquí puedes manejar los datos del formulario
      print('Usuario: $_usuario');
      print('Clave: $_clave');
      print('Email: $_email');
      print('Celular: $_celular');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Título en negrita
          ),
        ),
        backgroundColor: Colors.orange, // Color naranja
        centerTitle: true, // Centrar el título
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagen centrada en la parte superior
            Center(
              child: Image.asset(
                'assets/1.jpg', // Reemplaza con la ruta de tu imagen
                height: 100, // Ajusta el tamaño según sea necesario
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    'usuario',
                    'Usuario',
                    Colors.lightBlue,
                    icon: Icons.person,
                  ),
                  _buildTextField(
                    'clave',
                    'Clave',
                    Colors.lightGreen,
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  _buildTextField(
                    'email',
                    'Email',
                    Colors.orange,
                    icon: Icons.email,
                  ),
                  _buildTextField(
                    'celular',
                    'Celular',
                    Colors.purple,
                    keyboardType: TextInputType.phone,
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _submit,
                    icon: Icon(Icons.save), // Ícono en el botón de guardado
                    label: Text('Registrar'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String name, String label, Color color,
      {bool obscureText = false, TextInputType? keyboardType, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: color),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color, width: 2.0),
          ),
          prefixIcon: Icon(icon, color: color), // Ícono antes del texto
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor ingresa $label';
          } else if (name == 'email' &&
              !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Por favor ingresa un correo electrónico válido';
          } else if (name == 'celular' && value.length < 10) {
            return 'El número de celular debe tener al menos 10 dígitos';
          }
          return null;
        },
        onSaved: (value) {
          if (name == 'usuario') {
            _usuario = value;
          } else if (name == 'clave') {
            _clave = value;
          } else if (name == 'email') {
            _email = value;
          } else if (name == 'celular') {
            _celular = value;
          }
        },
      ),
    );
  }
}
