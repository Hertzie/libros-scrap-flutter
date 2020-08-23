import 'package:flutter/material.dart';
import 'package:libros/src/models/libro_model.dart';
import 'package:libros/src/widgets/libro_card.dart';

class FavoritosPage extends StatelessWidget {
  final List<Libro> favoritos;
  final String categoria;

  FavoritosPage({this.favoritos, this.categoria});
  

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Favoritos de ${categoria.toUpperCase()}'),
          centerTitle: false,
          backgroundColor: Colors.indigoAccent,
        ),
        body: Container(
          child: ListView.builder(
            itemCount: favoritos.length,
            padding: EdgeInsets.only(top: 15.0),
            itemBuilder: (context, index){
              return LibroCard(libro: favoritos[index]);
            },
          ),
        ),
      );
  }
}