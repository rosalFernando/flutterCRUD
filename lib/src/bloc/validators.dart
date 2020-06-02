

import 'dart:async';

class Validators{



  final validarEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){

      //patron para validar correo
     Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp= new RegExp(pattern);
    if(regExp.hasMatch(email)){
      sink.add(email);
    }else{
      sink.addError('Email no correcto');
    }
    }
  );
/*
Stream<bool> get formValidStream => 
    CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

*/

  final validarPass = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink){
      if(password.length >= 6){
        sink.add(password);
      }else{
        sink.addError('mas de 6 caracteres');
      }
    }
  );

  

}