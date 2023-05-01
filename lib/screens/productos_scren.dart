import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/services/producto_servicio.dart';
import 'package:productos_app/widgets/mensaje.dart';
import 'package:provider/provider.dart';
import '../providers/productos_form.dart';
import 'package:image_picker/image_picker.dart';

import 'screens.dart';

class ListaProductos extends StatelessWidget {
  const ListaProductos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prodServicio = Provider.of<ProductoServicio>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductosProviderClase(prodServicio.productoSelecionado),
      child: productosNuevos(prodServicio: prodServicio),
    );
  }
}

class productosNuevos extends StatelessWidget {
  const productosNuevos({
    Key? key,
    required this.prodServicio,
  }) : super(key: key);

  final ProductoServicio prodServicio;

  @override
  Widget build(BuildContext context) {
    final llave = GlobalKey<ScaffoldState>();
    final claseProductos = Provider.of<ProductosProviderClase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle Del Producto"),
        backgroundColor: Color.fromARGB(255, 228, 86, 43),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _ImagenProducto(url: prodServicio.productoSelecionado?.imagen),
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back_sharp,
                          size: 40, color: Color.fromARGB(255, 20, 20, 20))),
                ),
                Positioned(
                  top: 40,
                  right: 35,
                  child: IconButton(
                      onPressed: () async {
                        XFile? selectedImage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        PickedFile? pickedImage = selectedImage != null
                            ? PickedFile(selectedImage.path)
                            : null;
                        /* final picker = new ImagePicker();
                        final PickedFile? pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);*/

                        if (pickedImage == null) {
                          print(' no seleciono nada ');
                          return;
                        }

                        print("tenemos imagen ${pickedImage.path}");

                        prodServicio.imagenCamara(pickedImage.path);
                      },
                      icon: Icon(Icons.camera_alt,
                          size: 40, color: Color.fromARGB(255, 20, 20, 20))),
                )
              ],
            ),
            _ProductoForm(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_alt),
        backgroundColor: Color.fromARGB(255, 228, 86, 43),
        onPressed: () async {
          if (!claseProductos.esValido()) {
            return;
          } else {
            LoadingScreen();
            Navigator.of(context).pop();
          }

          final String? urlImagen = await prodServicio.actualizarImagen();

          if (urlImagen != null) claseProductos.productoDos!.imagen = urlImagen;

          await prodServicio.actualizaOCrea(claseProductos.productoDos!);
        },
      ),
    );
  }
}

class _ProductoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final traeNombreProducto = Provider.of<ProductosProviderClase>(context);
    final producto = traeNombreProducto.productoDos;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        height: 250,
        child: Form(
            key: traeNombreProducto.formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: producto?.nombre,
                  onChanged: (value) => producto?.nombre = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligatorio';
                  },
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Nombre', labelText: 'Nombre del Producto '),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  initialValue: '${producto?.precio}',
                  onChanged: (value) => producto?.precio = value,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: '\$200.00', labelText: 'Precio '),
                ),
                SizedBox(
                  height: 10,
                ),
                SwitchListTile.adaptive(
                  value: producto!.disponible,
                  title: Text("Disponible"),
                  activeColor: Color.fromARGB(255, 228, 86, 43),
                  onChanged: traeNombreProducto.actualizarBotonDisponible,
                )
              ],
            )),
      ),
    );
  }
}

class _ImagenProducto extends StatelessWidget {
  final String? url;

  const _ImagenProducto({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 200,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: ImagenesOpciones(url)),
        decoration: BoxDecoration(
            color: Colors.deepOrange, borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  Widget ImagenesOpciones(String? imagenes) {
    if (imagenes == '') {
      return Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
    }

    if (imagenes!.startsWith('http')) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(this.url!),
        fit: BoxFit.cover,
      );
    }

    return Image.file(File(imagenes), fit: BoxFit.cover);
  }
}
