

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formulariosbloc/src/bloc/provider.dart';

import 'package:formulariosbloc/src/model/producto_model.dart';
import 'package:formulariosbloc/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey=GlobalKey<FormState>();
  final scaffoldKey=GlobalKey<ScaffoldState>();
  ProductosBloc productosBloc;
  ProductoModel producto = new ProductoModel();
  bool _guardando=false;
  File foto;

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if(prodData != null){
      producto=prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
           onPressed: _seleccionarFoto
           ),
           IconButton(
            icon: Icon(Icons.camera_alt),
           onPressed: _hacerFoto
           ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(context),
                SizedBox(height: 20.0,),
                _crearBoton(context),
              ],
            ),
            ),
        ),
      ),
      
    );
  }

   Widget _crearNombre() {

   return TextFormField(
     initialValue: producto.titulo,
     textCapitalization: TextCapitalization.sentences,
     decoration: InputDecoration(
       labelText: 'Producto',
     ),
     onSaved: (value)=>producto.titulo=value,
     validator: (value){
       if(value.length < 3){
         return 'Ingrese el nombre del producto';
       }else{
         return null;
       }

      
     },
   );
 }

 Widget _crearPrecio() {

   return TextFormField(
     initialValue: producto.valor.toString(),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
     decoration: InputDecoration(
       labelText: 'Precio',
     ),

     onSaved: (value)=> producto.valor=double.parse(value),
     validator: (value){
       if(utils.isNumeric(value)){
         return null;
       }else{
         return 'Solo numeros';
       }
     },
   );
 }
Widget _crearDisponible(BuildContext context){
  return SwitchListTile(
    value: producto.disponible, 
    title: Text('Disponible'),
    activeColor: Theme.of(context).primaryColor,
    onChanged: (value)=> setState((){
      producto.disponible=value;
    }),
    );

}


 Widget _crearBoton(BuildContext context) {

   return RaisedButton.icon(
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(20.0),
     ),
     color: Theme.of(context).primaryColor,
     textColor: Colors.white,
     label: Text('Guardar'),
     icon:Icon(Icons.save),
     onPressed:(_guardando)?null: _submit,
     );
 }

 void _submit()async{

   if(!formKey.currentState.validate()){
     return;
   }

   formKey.currentState.save();
    

    setState(() {
      _guardando=true;
    });

    if(foto != null){
     producto.fotoUrl=await productosBloc.subirFoto(foto);
    }

   if(producto.id == null){
    productosBloc.agregarProducto(producto);
     
     mostrarSnackbar('Registro guardado');
     Navigator.pop(context);
   }else{
    productosBloc.editarProducto(producto);
    
    mostrarSnackbar('Registro actualizado');
    Navigator.pop(context);
   }

  

   
 }
 void mostrarSnackbar(String mensaje){
   final snackbar = SnackBar(
     content: Text(mensaje),
     duration: Duration(milliseconds: 1500),
     );
     scaffoldKey.currentState.showSnackBar(snackbar);
 }

Widget _mostrarFoto(){
     if (producto.fotoUrl != null) {
 
      return FadeInImage(
        placeholder: AssetImage('assets/original.gif'), 
        image: NetworkImage(producto.fotoUrl),
        height: 300.0,
        fit: BoxFit.contain,
        );
 
    } else {
 
      if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/original.png');
    }
 }

 _seleccionarFoto()async {

  _procesarImage(ImageSource.gallery);

 }

 _hacerFoto()async{
  _procesarImage(ImageSource.camera);
 }

 _procesarImage(ImageSource origen)async{
   foto=await ImagePicker.pickImage(
     source: origen
     );

     if(foto != null){
       producto.fotoUrl=null;
     }

     setState(() {
       
     });
 }
}