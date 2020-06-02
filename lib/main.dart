import 'package:flutter/material.dart';
import 'package:formulariosbloc/src/bloc/provider.dart';
import 'package:formulariosbloc/src/pages/home_page.dart';
import 'package:formulariosbloc/src/pages/login_page.dart';
import 'package:formulariosbloc/src/pages/producto_page.dart';
import 'package:formulariosbloc/src/pages/registro_page.dart';
import 'package:formulariosbloc/src/preferencias_usuario/preferencias_usuario.dart';
 
void main() async{
   final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login':(BuildContext context) => LoginPage(),
        'home':(BuildContext context) => HomePage(),
        'producto':(BuildContext context)=> ProductoPage(),
        'registro':(BuildContext context)=>RegistroPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
    ),
    );
    
    
   
  }
}