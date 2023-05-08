import 'package:flutter/material.dart';
import 'package:productos_app/screens/home_screen.dart';
import 'package:productos_app/screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

class VerificaScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final verificacion = Provider.of<Autenticacion>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: verificacion.leerToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
         
            if(!snapshot.hasData )
            return Text('Espere');

             if(snapshot.data == ''){
              Future.microtask((){

                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_,__,___,) => LoginScreen(),
                  transitionDuration: Duration(seconds: 0)
                ));
              });
             }  else{

                Future.microtask((){

                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_,__,___,) => HomeScreen(),
                  transitionDuration: Duration(seconds: 0)
                ));
              });

             }

             return Container();

          },
          ) 
      ),
    );
}
}