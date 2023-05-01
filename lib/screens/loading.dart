import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("Productos"),
        backgroundColor: Color.fromARGB(255, 228, 86, 43),
        centerTitle: true,
        ),
      body: Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 228, 86, 43),
        ),
     ),
   );
  }
}