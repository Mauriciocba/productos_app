// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class ProductosDos {
    ProductosDos({
    required this.disponible,
    required this.imagen,
    required this.nombre,
    required this.precio,
    this.id
    });

  bool disponible;
  String imagen;
  String nombre;
  String precio;
  String? id;

    factory ProductosDos.fromJson(String str) => ProductosDos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductosDos.fromMap(Map<String, dynamic> json) => ProductosDos(
         disponible: json["disponible"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"],
    );

    Map<String, dynamic> toMap() => {
       "disponible": disponible,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
    };

    ProductosDos copy() => ProductosDos(
      disponible: this.disponible,
      nombre: this.nombre,
      imagen: this.imagen,
      precio: this.precio,
      id: this.id,
    );

}
