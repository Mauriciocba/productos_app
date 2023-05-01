import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final traeProductos = Provider.of<ProductoServicio>(context);

     if (traeProductos.cargando)return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text("Productos"),
        backgroundColor: Color.fromARGB(255, 228, 86, 43),
        centerTitle: true,
      ),
      body: 
      ListView.builder(
        itemCount: traeProductos.productosArray.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            traeProductos.productoSelecionado =
                traeProductos.productosArray[index].copy();
            Navigator.pushNamed(context, 'productos');
          },
          child: 
           CardProductos(
            producto: traeProductos.productosArray[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 228, 86, 43),
        onPressed: () {
          traeProductos.productoSelecionado = new ProductosDos(
              disponible: true,
              nombre: "",
              precio: '0',
              imagen:'');
          Navigator.pushNamed(context, 'productos');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
