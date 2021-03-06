import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:libros/src/models/libro_model.dart';

class LibroPage extends StatefulWidget{

  final Libro libro;

  LibroPage({this.libro});
  
  @override
  _LibroPageState createState() => _LibroPageState();
}

class _LibroPageState extends State<LibroPage> {
  FToast fToast;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fToast = FToast(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.libro.tituloLibro),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: widget.libro.isFavorito ? Icon(Icons.star) : Icon(Icons.star_border), 
            onPressed: (){
              setState(() {
                widget.libro.isFavorito = !widget.libro.isFavorito;
              });
              _mostrarToastFavoritos();
            })
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            Image.network(widget.libro.imagen, width: 500.0, height: 150.0,),
            Text(widget.libro.categoria.toUpperCase(), style: TextStyle(color: Colors.indigoAccent)),
            Text(widget.libro.descripcion, style: TextStyle(fontSize: 12.0))
          ]
        ),
      )
    );
  }

  _mostrarToastFavoritos(){
    String mensaje = widget.libro.isFavorito 
                     ? 'Agregado a favoritos.' 
                     : 'Removido de favoritos';

    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: widget.libro.isFavorito ? Colors.indigoAccent : Colors.redAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            widget.libro.isFavorito ? Icon(Icons.check) : Icon(Icons.clear),
            SizedBox(
            width: 12.0,
            ),
            Text(mensaje),
        ],
        ),
    );


    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );

  }
}