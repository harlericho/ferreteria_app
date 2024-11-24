import 'package:flutter/material.dart';

Future<String?> showCustomDialog(BuildContext context, String title) async {
  String? input;
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          onChanged: (value) {
            input = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, input),
            child: Text('Guardar'),
          ),
        ],
      );
    },
  );
}
