import 'package:flutter/material.dart';


class ListaProductos extends StatelessWidget {
  const ListaProductos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  _ImagenProducto(),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon:Icon(Icons.arrow_back_sharp,size: 40, color: Color.fromARGB(255, 20, 20, 20) )
                      ),
                  ),
                   Positioned(
                    top: 40,
                    right: 35,
                    child: IconButton(
                      onPressed: () {},
                      icon:Icon(Icons.camera_alt,size: 40, color: Color.fromARGB(255, 20, 20, 20) )
                      ),
                  )
              ],
            ),

            _ProductoForm(),
            SizedBox(height: 100,)
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(child: Icon(Icons.save_alt),
      backgroundColor: Color.fromARGB(255, 228, 86, 43),
      onPressed: () {
        
      },),
    );
  }
}

class _ProductoForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        height: 200,
        child: Form(child: Column(children: [
          SizedBox(height: 10,),
          TextFormField(
            autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Nombre',
                  labelText: 'Nombre del Producto '
                ),
          ),
          SizedBox(height: 30,),
    
          TextFormField(
            autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '\$200.00',
                  labelText: 'Precio '
                ),
          ),
    
          SizedBox(height: 10,),
    
          SwitchListTile.adaptive(value: true,
          title: Text("Disponible"), activeColor: Color.fromARGB(255, 228, 86, 43), onChanged: (value) {
            
          },)
        ],)),
      ),
    );
  }
}

class _ImagenProducto extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: FadeInImage(
             placeholder: NetworkImage("https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg"),
            image: NetworkImage("https://i0.wp.com/imgs.hipertextual.com/wp-content/uploads/2020/01/hipertextual-es-figura-baby-yoda-mas-real-que-podras-comprar-2020062519.jpeg?fit=1920%2C1080&quality=50&strip=all&ssl=1"),
            fit: BoxFit.cover,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(25)
        ),
      ),
      
    );
  }
}

