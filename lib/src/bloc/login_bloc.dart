

import 'dart:async';

import 'package:formulariosbloc/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();


  //recuperar datos stream

 Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
 Stream<String> get passStream => _passController.stream.transform( validarPass );


//insertar valores al stream

Function(String) get changeEmail=>_emailController.sink.add;
Function(String) get changePass=>_passController.sink.add;

//metodo para habilitar boton si los valores son correctos

Stream<bool> get formValidStream => 
    CombineLatestStream.combine2(emailStream, passStream, (e, p) => true);


//obtener ultimo valor de Stream

String get email => _emailController.value;
String get pass => _passController.value;


dispose(){
  //simbolo de interrogacion para que no de error en caso de que el valor sea nulo
_emailController?.close();
_passController?.close();
}



}