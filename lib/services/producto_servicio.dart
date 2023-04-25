import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;


class ProductoServicio extends ChangeNotifier {
  final String _url = 'flutterbase-9808e-default-rtdb.firebaseio.com';
  final List<ProductosDos> productosArray = [];

  bool cargando = true;

  ProductoServicio() {
    this.cargarProductos();
  }
//
  Future<List<ProductosDos>> cargarProductos() async {
    // cargando = true;
    //notifyListeners();

    final url = Uri.https(_url, 'productos.json');
    final respuesta = await http.get(url);

    final Map<String, dynamic> productosMap = json.decode(respuesta.body);

    productosMap.forEach((key, value) {
      final productoTempo = ProductosDos.fromMap(value);
      productoTempo.id = key;
      this.productosArray.add(productoTempo);
    });

    // cargando = false;
    //  notifyListeners();
    print(productosArray);
    return this.productosArray;
  }
}
