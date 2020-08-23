import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:libros/src/models/libro_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:libros/src/widgets/libro_card.dart';
import 'package:libros/src/delegates/libro_search_delegate.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'favoritos_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  List<Libro> libros;
  List<Libro> librosFiltrados;
  List<String> categoriasState;
  String categoriaSeleccionada;
  Map<String, dynamic> jsonContent;
  final int numero = 5;
  bool loadingFlag = true;

  @override
  void initState() {
    super.initState();

    new Future<List<Libro>>.delayed(new Duration(seconds: 3), () => _obtenerLibrosFromJson()).then((value) => {
      setState((){
        libros = value;
        librosFiltrados = value;
      })
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> _getJsonData(String path) async{
    return await rootBundle.loadString(path);
  }

  Future<List<Libro>> _obtenerLibrosFromJson() async {
    String texto = await _getJsonData('assets/librosCategoria.json');
    jsonContent = jsonDecode(texto);
    List<dynamic> categorias = jsonContent['categorias'];
    List<dynamic> data = jsonContent['data'];
    libros = data.map((e) => Libro.mapFromJson(e)).toList();
    categoriasState = categorias.map((e) => e.toString()).toList();
    categoriasState.insert(0, 'TODOS');
    
    return libros;
  }

  @override
  Widget build(BuildContext context) {
    if(libros == null){
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Cargando libros...'),
          backgroundColor: Colors.indigoAccent,
        ),
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.indigoAccent,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        )
      );
    }else{
      return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Libros Scrapping'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: LibroSearchDelegate(listaLibros: libros));
            },
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
              _verFavoritos();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Categoria:'),
                DropdownButton<String>(
                  value : categoriaSeleccionada,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 20,
                  elevation: 15,
                  style: TextStyle(color: Colors.indigoAccent),
                  underline: Container(
                    height: 2,
                    color: Colors.indigoAccent
                  ),
                  onChanged: (String newValue){
                    setState((){
                      categoriaSeleccionada = newValue;
                      _filtrarLibrosPorCategoria(categoriaSeleccionada);
                    });
                  },
                  items: categoriasState.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value : value,
                      child: Text(value),
                    );
                  }).toList()
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                    itemCount: librosFiltrados.length,
                    padding: EdgeInsets.only(top: 15.0),
                    itemBuilder: (context, index){
                      return LibroCard(libro: librosFiltrados[index]);
                    },
              ),
            )
          ],
        )
      ),
    );
    }
  }

  void _filtrarLibrosPorCategoria(String categoria){
    setState(() {
      librosFiltrados = categoria == 'TODOS' ? libros : libros.where((libro) => libro.categoria == categoria).toList();
    });
  }

  void _verFavoritos(){
    if(categoriaSeleccionada == null || categoriaSeleccionada == ''){
      _mostrarToastOnNoCategoria();
      return;
    }
    List<Libro> favoritos = librosFiltrados.where((element) => element.isFavorito).toList();
    showMaterialModalBottomSheet(context: context, builder: (context, scrollController) => FavoritosPage(favoritos: favoritos, categoria: categoriaSeleccionada));
  }

  void _mostrarToastOnNoCategoria(){
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.indigoAccent,
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.priority_high),
            SizedBox(
            width: 12.0,
            ),
            Text('Seleccione una categoría.'),
        ],
        ),
    );
    
    FToast fToast = FToast(context);

    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
    );
  }
}
