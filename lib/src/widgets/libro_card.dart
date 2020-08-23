import 'package:flutter/material.dart';
import 'package:libros/src/models/libro_model.dart';
import 'package:libros/src/pages/libro_page.dart';

class LibroCard extends StatelessWidget {

  final Libro libro;

  LibroCard({@required this.libro});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => LibroPage(libro: libro)));
        },
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Image.network(libro.imagen, fit: BoxFit.fill),
                  backgroundColor: Colors.white,
                ),
                title: Text(libro.tituloLibro),
                subtitle: Text(libro.categoria.toUpperCase()),
                trailing: libro.isFavorito ? Icon(Icons.star) : Icon(Icons.star_border)
              )
            ],
          ),
      )
    );
  }

  Future<void> _alertLibro(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(libro.tituloLibro),
          content: Text(libro.upc),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}