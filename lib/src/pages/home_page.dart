import 'package:flutter/material.dart';
import 'package:formulariosbloc/src/bloc/provider.dart';
import 'package:formulariosbloc/src/model/producto_model.dart';



class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final productosBloc= Provider.productosBloc(context);
    productosBloc.cargarProductos();
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }

  Widget _crearListado(ProductosBloc productosBloc) {


return StreamBuilder(
  stream: productosBloc.productosStream ,
  builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
    if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context,productosBloc, productos[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
  },
    );
  }

  

  Widget _crearItem(BuildContext context,ProductosBloc productosBloc, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        productosBloc.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (producto.fotoUrl == null)
                ? Image(image: AssetImage('assets/original.png'))
                : FadeInImage(
                    placeholder: AssetImage('assets/original.gif'),
                    image: NetworkImage(producto.fotoUrl),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text('${producto.id}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'producto', arguments: producto),
            ),
          ],
        ),
      ),
    );
  }
}
/*
ListTile(
       title: Text('${producto.titulo} - ${producto.valor}'),
       subtitle: Text('${producto.id}'),
       onTap: ()=> Navigator.pushNamed(context, 'producto',arguments: producto),
     ),
     */
