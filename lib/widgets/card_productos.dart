import 'package:flutter/material.dart';
import '../models/models.dart';

class CardProductos extends StatelessWidget {
  final ProductosDos producto;

  const CardProductos({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(producto.nombre);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: EstilosCard(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _fondoCard(producto.imagen),
            _cardDetalles(producto.nombre, producto.id),
            Positioned(top: 0, right: 0, child: _precio(producto.precio)),
            if(producto.disponible)Positioned(top: 0, left: 0, child: _EstaDisponible())
          ],
        ),
      ),
    );
  }

  BoxDecoration EstilosCard() => BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _EstaDisponible extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Disponible',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    );
  }
}

class _precio extends StatelessWidget {
  final String? precios;

  const _precio(this.precios);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('\$$precios',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25), topRight: Radius.circular(25))),
    );
  }
}

class _cardDetalles extends StatelessWidget {
  final String? titulo;
  final String? id;

  const _cardDetalles(this.titulo, this.id) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _bordes_cardDetalles(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$titulo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "MODELO $id",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _bordes_cardDetalles() => BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25)));
}

class _fondoCard extends StatelessWidget {
  final String? urlImg;

  const _fondoCard(this.urlImg);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: urlImg == null
        ? Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover) 
        :FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(urlImg!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
