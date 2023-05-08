import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:provider/provider.dart';

import 'services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Autenticacion()),
        ChangeNotifierProvider(create: (_) => ProductoServicio())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'verifica',
      routes: {
        'login': (_) => LoginScreen(),
        'registro': (_) => RegistroScreen(),
        'verifica': (_) => VerificaScreen(),
        'home': (_) => HomeScreen(),
        'productos': (_) => ListaProductos(),
      },
      scaffoldMessengerKey: Notificaciones.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(color: Colors.deepOrangeAccent[900])),
    );
  }
}
