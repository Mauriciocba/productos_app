import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Autenticacion extends ChangeNotifier {

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _key = 'AIzaSyDN9BY16IH9GGXB5ZZ_KiKX9bT_lfyJj5I';
  final storage = new FlutterSecureStorage();

  Future<String?> crearUsuario (String email, String password)async {

    final Map<String, dynamic> autenticacion = {
      'email': email,
      'password': password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp',{'key': _key} );

    final respuesta = await http.post(url,body: json.encode(autenticacion));
    final Map<String, dynamic> respuesDecodificada = json.decode(respuesta.body);

    if (respuesDecodificada.containsKey('idToken')){
      await storage.write(key: 'token', value: respuesDecodificada['idToken']);
      return null;// respuesDecodificada['idToken'];
    }else{
      return respuesDecodificada['error']['message'];
    }
  }


 Future<String?> login (String email, String password)async {

    final Map<String, dynamic> autenticacion = {
      'email': email,
      'password': password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword',{'key': _key} );

    final respuesta = await http.post(url,body: json.encode(autenticacion));
    final Map<String, dynamic> respuesDecodificada = json.decode(respuesta.body);


    if (respuesDecodificada.containsKey('idToken')){
       await storage.write(key: 'token', value: respuesDecodificada['idToken']);
      return null;// respuesDecodificada['idToken'];
    }else{
      return respuesDecodificada['error']['message'];
    }
  }

  Future desloguearse() async{
    await storage.delete(key: 'token');
    return;
  }

  Future<String> leerToken()async{
    return await storage.read(key: 'token') ?? '';
  }

}