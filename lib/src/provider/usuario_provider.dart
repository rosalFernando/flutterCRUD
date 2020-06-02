import 'dart:convert';

import 'package:formulariosbloc/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firebaseToke = 'AIzaSyBUelJhgU9flmYUWWq3fo1yJyjep7dN6zE';
  final _prefs= new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String pass) async {
    final authData = {
      'email': email,
      'password': pass,
      'returnSecureToken': true
    };
    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToke',
        body: json.encode(authData));
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token=decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }


Future<Map<String, dynamic>>nuevoUsuario(String email, String pass) async {
  final authData = {
    'email': email,
    'password': pass,
    'returnSecureToken': true
  };
  final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToke',
      body: json.encode(authData));
  Map<String, dynamic> decodedResp = json.decode(resp.body);

  if (decodedResp.containsKey('idToken')) {
      _prefs.token=decodedResp['idToken'];
    return {'ok': true, 'token': decodedResp['idToken']};
  } else {
    return {'ok': false, 'mensaje': decodedResp['error']['message']};
  }
}
}
