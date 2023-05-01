import 'package:flutter/material.dart';

class Mensaje extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text('¡El producto se ha creado con éxito!'),
      backgroundColor: Colors.green,
    );
  }
}
