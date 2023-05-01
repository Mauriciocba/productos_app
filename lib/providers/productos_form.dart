import 'package:flutter/material.dart';
import '../models/models.dart';

class ProductosProviderClase extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  ProductosDos? productoDos;

  ProductosProviderClase(this.productoDos);

  actualizarBotonDisponible(bool value) {
    productoDos?.disponible = value;
    notifyListeners();
  }

  bool esValido() {
    print(productoDos?.nombre);
    print(productoDos?.disponible);
    print(productoDos?.precio);


    return formKey.currentState?.validate() ?? false;
  }
}
