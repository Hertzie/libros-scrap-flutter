import 'package:flutter/material.dart';
import 'package:libros/src/models/libro_model.dart';
import 'package:libros/src/widgets/libro_card.dart';

class LibroSearchDelegate extends SearchDelegate<Libro>{

  final List<Libro> listaLibros;

  @override
  String get searchFieldLabel => 'Buscar libro';

  LibroSearchDelegate({this.listaLibros});

  @override
  List<Widget> buildActions(BuildContext context) {
      // TODO: implement buildActions
      return [IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = "";
      })];
  }
  
    @override
    Widget buildLeading(BuildContext context) {
      // TODO: implement buildLeading
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          close(context, null);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // TODO: implement buildResults
      throw UnimplementedError();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
      final librosTemporal = query.isEmpty ? listaLibros : _getLibrosByQuery(listaLibros, query);
      return ListView.builder(
        itemCount: librosTemporal.length,
        itemBuilder: (context, index){
          final Libro libro = librosTemporal[index];
          return LibroCard(libro: libro);
        },
      );
    }

    List<Libro> _getLibrosByQuery(List<Libro> libros, String query){
      return libros.where((element) => element.tituloLibro.toLowerCase().contains(query)).toList();
    }
}