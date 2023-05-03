import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductoServicio extends ChangeNotifier {
  final String _url = 'flutterbase-9808e-default-rtdb.firebaseio.com';
  final List<ProductosDos> productosArray = [];
  late ProductosDos? productoSelecionado;

  File? nuevaImagen;
  bool cargando = true;
  bool guardar = false;

  ProductoServicio() {
    this.cargarProductos();
  }
//
  Future<List<ProductosDos>> cargarProductos() async {
     cargando = true;
    notifyListeners();

    final url = Uri.https(_url, 'productos.json');
    final respuesta = await http.get(url);

    final Map<String, dynamic> productosMap = json.decode(respuesta.body);

    productosMap.forEach((key, value) {
      final productoTempo = ProductosDos.fromMap(value);
      productoTempo.id = key;
      this.productosArray.add(productoTempo);
    });

    cargando = false;
    notifyListeners();
    print(productosArray);
    return this.productosArray;
  }

  //actualizar card
  Future actualizaOCrea(ProductosDos producto) async {
    cargando = true;
    guardar = true;
    notifyListeners();

    if (producto.id == null) {
      await crearProducto(producto);
    } else {
      //actualiza
      await actualizarProducto(producto);
    }
    
    cargando = false;
    guardar = false;
    notifyListeners();
  }

  Future<String> actualizarProducto(ProductosDos producto) async {
    final url = Uri.https(_url, 'productos/${producto.id}.json');
    final respuesta = await http.put(url, body: producto.toJson());
    final data = respuesta.body;

    final index =
        productosArray.indexWhere((element) => element.id == producto.id);
    this.productosArray[index] = producto;

    return producto.id!;
  }

  Future<String> crearProducto(ProductosDos producto) async {
    final url = Uri.https(_url, 'productos.json');
    final respuesta = await http.post(url, body: producto.toJson());
    final data = json.decode(respuesta.body);

    producto.id = data['name'];

    this.productosArray.add(producto);

    return producto.id!;
  }

  void imagenCamara(String path) {
    productoSelecionado?.imagen = path;
    nuevaImagen = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> actualizarImagen() async {
    if (nuevaImagen == null) return null;

    this.guardar = true;
    notifyListeners();

    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/dtma1lffp/image/upload?upload_preset=flutterProductos");

    final imagenRespuesta = http.MultipartRequest('POST', url);

    final archivo =
        await http.MultipartFile.fromPath('file', nuevaImagen!.path);

    imagenRespuesta.files.add(archivo);

    final respuestaFinal = await imagenRespuesta.send();
    final resp = await http.Response.fromStream(respuestaFinal);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print("Algo salio mal");
      print(resp.body);
      return null;
    }

    nuevaImagen = null;

    final respuestaJsonData = json.decode(resp.body);
    return respuestaJsonData['secure_url'];
  }
}
